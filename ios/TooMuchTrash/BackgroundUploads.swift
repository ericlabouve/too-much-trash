import Foundation
import UIKit

/// File-backed transfers survive ordinary suspension. iOS still controls scheduling;
/// force-quitting prevents delivery until the user launches the app again.
final class BackgroundUploads: NSObject, URLSessionDataDelegate, @unchecked Sendable {
    static let shared = BackgroundUploads()
    static let identifier = "org.toomuchtrash.video-uploads.v1"
    static let largerChunkSize = 4 * 1024 * 1024
    static let maximumConcurrentChunks = 4
    private let lock = NSLock()
    private struct Handler {
        let continuation: CheckedContinuation<(Data, HTTPURLResponse), Error>
        let progress: @MainActor @Sendable (Int64, Int64) -> Void
    }
    private var handlers: [Int: Handler] = [:]
    private var responses: [Int: Data] = [:]
    private var finished: [Int: Result<(Data, HTTPURLResponse), Error>] = [:]
    private var recovered: [UUID: @MainActor @Sendable (URLRequest, Data, HTTPURLResponse) -> Void] = [:]
    private var finishEvents: (() -> Void)?
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.background(withIdentifier: Self.identifier)
        configuration.sessionSendsLaunchEvents = true
        configuration.isDiscretionary = false
        configuration.waitsForConnectivity = true
        configuration.allowsCellularAccess = true
        configuration.httpCookieStorage = nil
        configuration.httpShouldSetCookies = false
        configuration.urlCache = nil
        configuration.timeoutIntervalForResource = 24 * 60 * 60
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return URLSession(configuration: configuration, delegate: self, delegateQueue: queue)
    }()

    static var stagingDirectory: URL {
        FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("UploadTransfers", isDirectory: true)
    }

    func setRecoveredHandler(_ handler: @escaping @MainActor @Sendable (URLRequest, Data, HTTPURLResponse) -> Void) -> UUID {
        let id = UUID()
        lock.lock(); recovered[id] = handler; lock.unlock()
        _ = session
        return id
    }

    func removeRecoveredHandler(_ id: UUID) { lock.lock(); recovered.removeValue(forKey: id); lock.unlock() }

    func handleEvents(completion: @escaping () -> Void) {
        lock.lock(); finishEvents = completion; lock.unlock()
        _ = session
    }

    private final class CancellationBox: @unchecked Sendable {
        private let lock = NSLock()
        private var task: URLSessionTask?
        private var cancelled = false
        func set(_ value: URLSessionTask) {
            lock.lock(); task = value; let shouldCancel = cancelled; lock.unlock()
            if shouldCancel { value.cancel() }
        }
        func cancel() { lock.lock(); cancelled = true; let value = task; lock.unlock(); value?.cancel() }
    }

    func upload(request: URLRequest, file: URL,
                progress: @escaping @MainActor @Sendable (Int64, Int64) -> Void) async throws -> (Data, HTTPURLResponse) {
        let tasks = await session.allTasks
        let key = request.value(forHTTPHeaderField: "Idempotency-Key")
        let chunkSize = request.value(forHTTPHeaderField: "X-TMT-Chunk-Size")
        let existing = tasks.first { $0.originalRequest?.url == request.url &&
            $0.originalRequest?.value(forHTTPHeaderField: "Idempotency-Key") == key &&
            $0.originalRequest?.value(forHTTPHeaderField: "X-TMT-Chunk-Size") == chunkSize }
        let box = CancellationBox()
        return try await withTaskCancellationHandler(operation: {
            try await withCheckedThrowingContinuation { continuation in
                let task = existing ?? session.uploadTask(with: request, fromFile: file)
                task.taskDescription = key
                lock.lock()
                if let completed = finished.removeValue(forKey: task.taskIdentifier) {
                    lock.unlock()
                    continuation.resume(with: completed)
                    return
                }
                handlers[task.taskIdentifier] = Handler(continuation: continuation, progress: progress)
                lock.unlock()
                box.set(task)
                task.resume()
            }
        }, onCancel: { box.cancel() })
    }

    func activeCaptureIDs() async -> Set<UUID> {
        Set(await session.allTasks.compactMap { task in
            task.originalRequest?.value(forHTTPHeaderField: "Idempotency-Key").flatMap(UUID.init(uuidString:))
        })
    }

    func cancel(captureIDs: Set<UUID>, origin: URL) async {
        for task in await session.allTasks {
            guard let request = task.originalRequest, let requestURL = request.url,
                  let key = request.value(forHTTPHeaderField: "Idempotency-Key"), let id = UUID(uuidString: key),
                  captureIDs.contains(id) else { continue }
            let ordinary = [origin.appendingPathComponent("api/v1/media"), origin.appendingPathComponent("api/v1/episodes")].contains(requestURL)
            let transferPrefix = origin.appendingPathComponent("api/v1/episodes/\(id.uuidString)/transfer").absoluteString + "/"
            guard ordinary || requestURL.absoluteString.hasPrefix(transferPrefix) else { continue }
            task.cancel()
        }
    }

    private func chunkName(for request: URLRequest?, key: String?) -> String? {
        guard let request, let key, UUID(uuidString: key) != nil, let url = request.url else { return nil }
        let parts = url.pathComponents
        guard parts.count >= 7, parts[parts.count - 3] == "transfer",
              UUID(uuidString: parts[parts.count - 4]) == UUID(uuidString: key),
              ["video", "imu", "poses", "manifest"].contains(parts[parts.count - 2]),
              let index = Int(parts.last ?? ""), index >= 0 else { return nil }
        return Self.chunkFileName(episodeID: key, name: parts[parts.count - 2], index: index,
                                  chunkSize: request.value(forHTTPHeaderField: "X-TMT-Chunk-Size"))
    }

    static func chunkFileName(episodeID: String, name: String, index: Int, chunkSize: String?) -> String {
        let largerSize = String(largerChunkSize)
        let suffix = chunkSize == largerSize ? "." + largerSize : ""
        return "\(episodeID).\(name).\(index)\(suffix).chunk"
    }

    func cleanOrphanedChunks(captureID: UUID) async throws {
        let tasks = await session.allTasks
        let protected = Set(tasks.compactMap { chunkName(for: $0.originalRequest, key: $0.taskDescription) })
        let contents = (try? FileManager.default.contentsOfDirectory(at: Self.stagingDirectory, includingPropertiesForKeys: nil)) ?? []
        for file in contents where file.lastPathComponent.hasPrefix(captureID.uuidString + ".") && file.pathExtension == "chunk" {
            if !protected.contains(file.lastPathComponent) { try FileManager.default.removeItem(at: file) }
        }
    }

    func urlSession(_ session: URLSession, task: URLSessionTask,
                    willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest,
                    completionHandler: @escaping (URLRequest?) -> Void) { completionHandler(nil) }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        lock.lock()
        var body = responses[dataTask.taskIdentifier] ?? Data()
        if body.count + data.count <= 1024 * 1024 { body.append(data) }
        responses[dataTask.taskIdentifier] = body
        lock.unlock()
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64,
                    totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        lock.lock(); let handler = handlers[task.taskIdentifier]; lock.unlock()
        if let handler { Task { @MainActor in handler.progress(totalBytesSent, totalBytesExpectedToSend) } }
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        lock.lock()
        let handler = handlers.removeValue(forKey: task.taskIdentifier)
        let data = responses.removeValue(forKey: task.taskIdentifier) ?? Data()
        let callbacks = Array(recovered.values)
        let response = task.response as? HTTPURLResponse
        let request = task.originalRequest
        let result: Result<(Data, HTTPURLResponse), Error>
        if let error { result = .failure(error) }
        else if let response, response.url == request?.url { result = .success((data, response)) }
        else { result = .failure(ClientError.invalidResponse) }
        if handler == nil {
            finished[task.taskIdentifier] = result
            if finished.count > 128, let oldest = finished.keys.min() { finished.removeValue(forKey: oldest) }
        }
        lock.unlock()
        if let key = task.taskDescription, UUID(uuidString: key) != nil {
            if let chunk = chunkName(for: request, key: key) {
                try? FileManager.default.removeItem(at: Self.stagingDirectory.appendingPathComponent(chunk))
            } else {
                try? FileManager.default.removeItem(at: Self.stagingDirectory.appendingPathComponent(key + ".multipart"))
            }
        }
        if let handler { handler.continuation.resume(with: result) }
        else if case .success(let (data, response)) = result, let request {
            Task { @MainActor in for callback in callbacks { callback(request, data, response) } }
        }
    }

    func removeStaged(captureIDs: Set<UUID>) throws {
        let contents = (try? FileManager.default.contentsOfDirectory(at: Self.stagingDirectory, includingPropertiesForKeys: nil)) ?? []
        for id in captureIDs {
            for suffix in [".multipart", ".building"] {
                let file = Self.stagingDirectory.appendingPathComponent(id.uuidString + suffix)
                if FileManager.default.fileExists(atPath: file.path) { try FileManager.default.removeItem(at: file) }
            }
            let prefix = id.uuidString + "."
            for file in contents where file.lastPathComponent.hasPrefix(prefix) && file.pathExtension == "chunk" {
                try FileManager.default.removeItem(at: file)
            }
        }
    }

    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        lock.lock(); let completion = finishEvents; finishEvents = nil; lock.unlock()
        if let completion { DispatchQueue.main.async(execute: completion) }
    }
}

final class UploadAppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String,
                     completionHandler: @escaping () -> Void) {
        guard identifier == BackgroundUploads.identifier else { completionHandler(); return }
        BackgroundUploads.shared.handleEvents(completion: completionHandler)
    }
}
