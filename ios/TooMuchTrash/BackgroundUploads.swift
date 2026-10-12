import Foundation
import UIKit

/// File-backed transfers survive ordinary suspension. iOS still controls scheduling;
/// force-quitting prevents delivery until the user launches the app again.
final class BackgroundUploads: NSObject, URLSessionDataDelegate, @unchecked Sendable {
    static let shared = BackgroundUploads()
    static let identifier = "org.toomuchtrash.video-uploads.v1"
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
        let existing = tasks.first { $0.originalRequest?.url == request.url &&
            $0.originalRequest?.value(forHTTPHeaderField: "Idempotency-Key") == key }
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

    func cancel(captureIDs: Set<UUID>, origin: URL) async {
        for task in await session.allTasks {
            guard let request = task.originalRequest,
                  request.url == origin.appendingPathComponent("api/v1/media"),
                  let key = request.value(forHTTPHeaderField: "Idempotency-Key"), let id = UUID(uuidString: key),
                  captureIDs.contains(id) else { continue }
            task.cancel()
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
            try? FileManager.default.removeItem(at: Self.stagingDirectory.appendingPathComponent(key + ".multipart"))
        }
        if let handler { handler.continuation.resume(with: result) }
        else if case .success(let (data, response)) = result, let request {
            Task { @MainActor in for callback in callbacks { callback(request, data, response) } }
        }
    }

    func removeStaged(captureIDs: Set<UUID>) throws {
        for id in captureIDs {
            for suffix in [".multipart", ".building"] {
                let file = Self.stagingDirectory.appendingPathComponent(id.uuidString + suffix)
                if FileManager.default.fileExists(atPath: file.path) { try FileManager.default.removeItem(at: file) }
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
