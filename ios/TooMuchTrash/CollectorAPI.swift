import Foundation
import CryptoKit

@MainActor
protocol HTTPTransport {
    func data(for request: URLRequest) async throws -> (Data, HTTPURLResponse)
    func upload(for request: URLRequest, from file: URL) async throws -> (Data, HTTPURLResponse)
    func upload(for request: URLRequest, from file: URL,
                progress: @escaping @MainActor @Sendable (Int64, Int64) -> Void) async throws -> (Data, HTTPURLResponse)
}

extension HTTPTransport {
    func upload(for request: URLRequest, from file: URL,
                progress: @escaping @MainActor @Sendable (Int64, Int64) -> Void) async throws -> (Data, HTTPURLResponse) {
        try await upload(for: request, from: file)
    }
}

// Never forward a bearer, refresh token, or invite to a redirected destination.
final class RefuseRedirects: NSObject, URLSessionTaskDelegate, @unchecked Sendable {
    func urlSession(_ session: URLSession, task: URLSessionTask,
                    willPerformHTTPRedirection response: HTTPURLResponse,
                    newRequest request: URLRequest,
                    completionHandler: @escaping (URLRequest?) -> Void) {
        completionHandler(nil)
    }
}

@MainActor
final class SecureHTTPTransport: HTTPTransport {
    private let session: URLSession
    init() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.httpCookieStorage = nil
        configuration.urlCache = nil
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 300
        session = URLSession(configuration: configuration, delegate: RefuseRedirects(), delegateQueue: nil)
    }

    func data(for request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let (data, response) = try await session.data(for: request)
        return try checked(data, response, request)
    }

    func upload(for request: URLRequest, from file: URL) async throws -> (Data, HTTPURLResponse) {
        try await upload(for: request, from: file, progress: { _, _ in })
    }

    func upload(for request: URLRequest, from file: URL,
                progress: @escaping @MainActor @Sendable (Int64, Int64) -> Void) async throws -> (Data, HTTPURLResponse) {
        let (data, response) = try await BackgroundUploads.shared.upload(request: request, file: file, progress: progress)
        return try checked(data, response, request)
    }

    private func checked(_ data: Data, _ response: URLResponse, _ request: URLRequest) throws -> (Data, HTTPURLResponse) {
        guard let http = response as? HTTPURLResponse, http.url == request.url else {
            throw ClientError.invalidResponse
        }
        return (data, http)
    }
}

@MainActor
protocol CollectorAPI {
    func enroll(invite: String, name: String?) async throws -> Enrollment
    func refresh(token: String) async throws -> AccessToken
    func me(token: String) async throws -> Installation
    func upload(file: URL, token: String) async throws -> MediaReceipt
    func upload(file: URL, captureID: UUID, token: String,
                progress: @escaping @MainActor @Sendable (Int64, Int64) -> Void) async throws -> MediaReceipt
    func uploaded(captureID: UUID, token: String) async throws -> MediaReceipt
    func deleteVideo(captureID: UUID, token: String) async throws
    func endSession(refreshToken: String) async throws -> EndSessionReceipt
    func media(id: UUID, token: String) async throws -> MediaReceipt
    func adminReachable() async -> Bool
    func availableServers() async throws -> [AvailableServer]
    func developmentEnroll(key: String) async throws -> Enrollment
    func uploadEpisode(directory: URL, episodeID: UUID, token: String,
                       progress: @escaping @MainActor @Sendable (Int64, Int64) -> Void) async throws -> MediaReceipt
    func uploadResumableEpisode(directory: URL, episodeID: UUID, token: String, chunkLimit: Int,
                       progress: @escaping @MainActor @Sendable (Int64, Int64) -> Void) async throws -> MediaReceipt
}

extension CollectorAPI {
    func developmentEnroll(key: String) async throws -> Enrollment { throw ClientError.configuration }
    func uploadEpisode(directory: URL, episodeID: UUID, token: String,
                       progress: @escaping @MainActor @Sendable (Int64, Int64) -> Void) async throws -> MediaReceipt { throw ClientError.configuration }
    func uploadResumableEpisode(directory: URL, episodeID: UUID, token: String,
                       progress: @escaping @MainActor @Sendable (Int64, Int64) -> Void) async throws -> MediaReceipt {
        try await uploadResumableEpisode(directory: directory, episodeID: episodeID, token: token,
                                         chunkLimit: BackgroundUploads.maximumConcurrentChunks, progress: progress)
    }
    func uploadResumableEpisode(directory: URL, episodeID: UUID, token: String, chunkLimit: Int,
                       progress: @escaping @MainActor @Sendable (Int64, Int64) -> Void) async throws -> MediaReceipt { throw ClientError.configuration }
    func availableServers() async throws -> [AvailableServer] { [] }
    func upload(file: URL, captureID: UUID, token: String,
                progress: @escaping @MainActor @Sendable (Int64, Int64) -> Void) async throws -> MediaReceipt {
        try await upload(file: file, token: token)
    }
    func uploaded(captureID: UUID, token: String) async throws -> MediaReceipt { throw ClientError.missingMedia }
    func deleteVideo(captureID: UUID, token: String) async throws { throw ClientError.developmentRequired }
    func endSession(refreshToken: String) async throws -> EndSessionReceipt { throw ClientError.configuration }
}

@MainActor
final class LiveCollectorAPI: CollectorAPI {
    private struct Failure: Decodable {
        struct Detail: Decodable { let code: String }
        let detail: Detail
    }
    private let configuration: APIConfiguration
    private let transport: HTTPTransport

    init(configuration: APIConfiguration, transport: HTTPTransport? = nil) {
        self.configuration = configuration
        self.transport = transport ?? SecureHTTPTransport()
    }

    func enroll(invite: String, name: String?) async throws -> Enrollment {
        var body = ["invite_code": invite]
        if let name, !name.isEmpty { body["installation_name"] = name }
        return try await json(path: "api/v1/auth/enroll", body: body, status: 201)
    }

    func developmentEnroll(key: String) async throws -> Enrollment {
        guard configuration.publicOrigin == APIConfiguration.developmentNetwork.publicOrigin,
              let origin = configuration.privateAdminOrigin,
              origin == APIConfiguration.developmentNetwork.privateAdminOrigin else { throw ClientError.configuration }
        var request = URLRequest(url: origin.appendingPathComponent("api/v1/admin/development-enroll"))
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(["key": key])
        let (data, response) = try await transport.data(for: request)
        guard response.url == request.url else { throw ClientError.invalidResponse }
        return try decode(data, response, expected: 201)
    }

    func refresh(token: String) async throws -> AccessToken {
        try await json(path: "api/v1/auth/token", body: ["refresh_token": token])
    }

    func me(token: String) async throws -> Installation {
        try await json(path: "api/v1/auth/me", token: token)
    }

    func media(id: UUID, token: String) async throws -> MediaReceipt {
        try await json(path: "api/v1/media/\(id.uuidString)", token: token)
    }

    func uploaded(captureID: UUID, token: String) async throws -> MediaReceipt {
        try await json(path: "api/v1/media/by-client/\(captureID.uuidString)", token: token)
    }

    func deleteVideo(captureID: UUID, token: String) async throws {
        struct Deletion: Decodable { let client_capture_id: UUID; let deleted: Bool }
        var request = URLRequest(url: configuration.endpoint("api/v1/media/by-client/\(captureID.uuidString)"))
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let (data, response) = try await transport.data(for: request)
        guard response.url == request.url else { throw ClientError.invalidResponse }
        let result: Deletion = try decode(data, response, expected: 200)
        guard result.deleted, result.client_capture_id == captureID else { throw ClientError.invalidResponse }
    }

    func endSession(refreshToken: String) async throws -> EndSessionReceipt {
        try await json(path: "api/v1/auth/end-session", body: ["refresh_token": refreshToken])
    }

    private func json<T: Decodable>(path: String, body: [String: String]? = nil,
                                     token: String? = nil, status: Int = 200) async throws -> T {
        var request = URLRequest(url: configuration.endpoint(path))
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.cachePolicy = .reloadIgnoringLocalCacheData
        if let token { request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization") }
        if let body {
            request.httpMethod = "POST"
            request.httpBody = try JSONEncoder().encode(body)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        let (data, response) = try await transport.data(for: request)
        guard response.url == request.url else { throw ClientError.invalidResponse }
        return try decode(data, response, expected: status)
    }

    func adminReachable() async -> Bool {
        guard let origin = configuration.privateAdminOrigin else { return false }
        var request = URLRequest(url: origin.appendingPathComponent("api/v1/admin/reachability"))
        request.timeoutInterval = 3
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        struct Identity: Decodable { let service: String; let version: Int }
        do {
            let (data, response) = try await transport.data(for: request)
            guard response.url == request.url else { return false }
            let identity: Identity = try decode(data, response, expected: 200)
            return identity.service == "too-much-trash-admin" && identity.version == 1
        } catch { return false }
    }

    func availableServers() async throws -> [AvailableServer] {
        guard let origin = configuration.privateAdminOrigin, origin.scheme == "https" else {
            throw ClientError.configuration
        }
        var request = URLRequest(url: origin.appendingPathComponent("api/v1/admin/servers"))
        request.timeoutInterval = 3
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let (data, response) = try await transport.data(for: request)
        guard response.url == request.url, data.count <= 65_536 else { throw ClientError.invalidResponse }
        struct Catalog: Decodable { let service: String; let version: Int; let servers: [AvailableServer] }
        let catalog: Catalog = try decode(data, response, expected: 200)
        guard catalog.service == "too-much-trash-admin", catalog.version == 1,
              catalog.servers.count <= 32,
              Set(catalog.servers.map(\.id)).count == catalog.servers.count,
              Set(catalog.servers.compactMap { $0.configuration?.privateAdminOrigin }).count == catalog.servers.count,
              catalog.servers.allSatisfy({ $0.isValid(inTailnetOf: origin) }) else {
            throw ClientError.invalidResponse
        }
        return catalog.servers
    }

    func upload(file: URL, token: String) async throws -> MediaReceipt {
        try await upload(file: file, captureID: UUID(), token: token, progress: { _, _ in })
    }

    func uploadEpisode(directory: URL, episodeID: UUID, token: String,
                       progress: @escaping @MainActor @Sendable (Int64, Int64) -> Void) async throws -> MediaReceipt {
        let parts = [("video", "video.mp4", "video/mp4"), ("imu", "imu.jsonl", "application/x-ndjson"),
                     ("poses", "poses.jsonl", "application/x-ndjson"), ("manifest", "manifest.json", "application/json")]
        var total: Int64 = 0
        for (_, filename, _) in parts {
            let attributes = try FileManager.default.attributesOfItem(atPath: directory.appendingPathComponent(filename).path)
            guard let size = attributes[.size] as? NSNumber, size.int64Value > 0 else { throw ClientError.invalidResponse }
            total += size.int64Value
            guard total <= 200 * 1024 * 1024 else { throw ClientError.uploadTooLarge }
        }
        let boundary = "TMT-\(episodeID.uuidString)"
        let staging = BackgroundUploads.stagingDirectory
        try FileManager.default.createDirectory(at: staging, withIntermediateDirectories: true)
        try CaptureQueue.protect(staging)
        let bodyURL = staging.appendingPathComponent(episodeID.uuidString + ".multipart")
        if !FileManager.default.fileExists(atPath: bodyURL.path) {
            try await Task.detached(priority: .utility) {
                try Self.stageEpisode(directory: directory, bodyURL: bodyURL, boundary: boundary)
            }.value
        }
        var request = URLRequest(url: configuration.endpoint("api/v1/episodes"))
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue(episodeID.uuidString, forHTTPHeaderField: "Idempotency-Key")
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        defer { try? FileManager.default.removeItem(at: bodyURL) }
        let (data, response) = try await transport.upload(for: request, from: bodyURL, progress: progress)
        guard response.url == request.url else { throw ClientError.invalidResponse }
        return try decode(data, response, expected: 202)
    }

    private struct ResumableFile: Codable, Sendable {
        let size: Int64
        let sha256: String
    }
    private struct ResumableBegin: Encodable { let files: [String: ResumableFile] }
    private struct ResumableState: Decodable { let complete: Bool; let chunk_size: Int; let chunks: [String: [Int]] }
    private struct ResumableAccepted: Decodable { let accepted: Bool }
    @MainActor private final class ChunkProgress {
        var open = true
        var sent: Int64
        var bytesByIndex: [Int: Int64] = [:]

        init(sent: Int64) { self.sent = sent }

        func update(index: Int, bytes: Int64) {
            let previous = bytesByIndex[index, default: 0]
            guard bytes > previous else { return }
            bytesByIndex[index] = bytes
            sent += bytes - previous
        }
    }
    private nonisolated static let episodeFileNames = [("video", "video.mp4"), ("imu", "imu.jsonl"),
                                           ("poses", "poses.jsonl"), ("manifest", "manifest.json")]

    func uploadResumableEpisode(directory: URL, episodeID: UUID, token: String, chunkLimit: Int,
                                progress: @escaping @MainActor @Sendable (Int64, Int64) -> Void) async throws -> MediaReceipt {
        let descriptors = try await Task.detached(priority: .utility) { try Self.describeEpisode(directory) }.value
        let total = descriptors.values.reduce(Int64(0)) { $0 + $1.size }
        guard total > 0, total <= 200 * 1024 * 1024 else { throw ClientError.uploadTooLarge }
        let path = "api/v1/episodes/\(episodeID.uuidString)/transfer"
        var begin = URLRequest(url: configuration.endpoint(path))
        begin.httpMethod = "POST"
        begin.httpBody = try JSONEncoder().encode(ResumableBegin(files: descriptors))
        begin.setValue("application/json", forHTTPHeaderField: "Content-Type")
        begin.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        begin.setValue(String(BackgroundUploads.largerChunkSize), forHTTPHeaderField: "X-TMT-Chunk-Size")
        let (beginData, beginResponse) = try await transport.data(for: begin)
        guard beginResponse.url == begin.url else { throw ClientError.invalidResponse }
        let state: ResumableState = try decode(beginData, beginResponse, expected: 200)
        if state.complete { return try await uploaded(captureID: episodeID, token: token) }
        let largeChunks = state.chunk_size == BackgroundUploads.largerChunkSize
        guard (state.chunk_size == 1024 * 1024 || largeChunks),
              Set(state.chunks.keys) == Set(descriptors.keys) else { throw ClientError.invalidResponse }
        let chunkSize = Int64(state.chunk_size)
        let staging = BackgroundUploads.stagingDirectory
        try FileManager.default.createDirectory(at: staging, withIntermediateDirectories: true)
        try CaptureQueue.protect(staging)
        try await BackgroundUploads.shared.cleanOrphanedChunks(captureID: episodeID)
        var sent: Int64 = 0
        var missing: [(name: String, source: URL, index: Int, size: Int64)] = []
        for (name, filename) in Self.episodeFileNames {
            guard let descriptor = descriptors[name], let uploaded = state.chunks[name] else { throw ClientError.invalidResponse }
            let count = Int((descriptor.size + chunkSize - 1) / chunkSize)
            let accepted = Set(uploaded)
            guard accepted.count == uploaded.count, accepted.allSatisfy({ $0 >= 0 && $0 < count }) else { throw ClientError.invalidResponse }
            let source = directory.appendingPathComponent(filename)
            for index in 0..<count {
                let size = min(chunkSize, descriptor.size - Int64(index) * chunkSize)
                if accepted.contains(index) { sent += size }
                else { missing.append((name, source, index, size)) }
            }
        }
        progress(sent, total)
        let tracker = ChunkProgress(sent: sent)
        defer { tracker.open = false }
        let parallelism = largeChunks ? min(max(1, chunkLimit), BackgroundUploads.maximumConcurrentChunks) : 1
        let chunkHeader = largeChunks ? String(chunkSize) : nil
        try await withThrowingTaskGroup(of: Void.self) { group in
            for (position, chunk) in missing.enumerated() {
                if position >= parallelism { _ = try await group.next() }
                try Task.checkCancellation()
                group.addTask { @MainActor in
                    let bodyURL = staging.appendingPathComponent(BackgroundUploads.chunkFileName(
                        episodeID: episodeID.uuidString, name: chunk.name, index: chunk.index, chunkSize: chunkHeader))
                    defer { try? FileManager.default.removeItem(at: bodyURL) }
                    try await Task.detached(priority: .utility) {
                        try Self.stageChunk(source: chunk.source, target: bodyURL,
                                            offset: UInt64(Int64(chunk.index) * chunkSize), size: Int(chunk.size))
                    }.value
                    try Task.checkCancellation()
                    var request = URLRequest(url: self.configuration.endpoint("\(path)/\(chunk.name)/\(chunk.index)"))
                    request.httpMethod = "PUT"
                    request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
                    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                    request.setValue(episodeID.uuidString, forHTTPHeaderField: "Idempotency-Key")
                    request.setValue(chunkHeader, forHTTPHeaderField: "X-TMT-Chunk-Size")
                    let (data, response) = try await self.transport.upload(for: request, from: bodyURL) { current, _ in
                        guard tracker.open else { return }
                        tracker.update(index: position, bytes: min(chunk.size, current))
                        progress(tracker.sent, total)
                    }
                    guard response.url == request.url else { throw ClientError.invalidResponse }
                    let receipt: ResumableAccepted = try self.decode(data, response, expected: 200)
                    guard receipt.accepted else { throw ClientError.invalidResponse }
                    tracker.update(index: position, bytes: chunk.size)
                    progress(tracker.sent, total)
                }
            }
            for try await _ in group {}
        }
        tracker.open = false
        var finish = URLRequest(url: configuration.endpoint("\(path)/finish"))
        finish.httpMethod = "POST"
        finish.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let (data, response) = try await transport.data(for: finish)
        guard response.url == finish.url else { throw ClientError.invalidResponse }
        return try decode(data, response, expected: 202)
    }

    private nonisolated static func describeEpisode(_ directory: URL) throws -> [String: ResumableFile] {
        var result: [String: ResumableFile] = [:]
        for (name, filename) in episodeFileNames {
            let url = directory.appendingPathComponent(filename)
            let source = try FileHandle(forReadingFrom: url)
            defer { try? source.close() }
            var digest = SHA256()
            var size: Int64 = 0
            while let data = try source.read(upToCount: 1024 * 1024), !data.isEmpty {
                digest.update(data: data)
                size += Int64(data.count)
            }
            guard size > 0 else { throw ClientError.storage }
            result[name] = ResumableFile(size: size, sha256: digest.finalize().map { String(format: "%02x", $0) }.joined())
        }
        return result
    }

    private nonisolated static func stageChunk(source: URL, target: URL, offset: UInt64, size: Int) throws {
        let input = try FileHandle(forReadingFrom: source)
        defer { try? input.close() }
        try input.seek(toOffset: offset)
        guard let bytes = try input.read(upToCount: size), bytes.count == size else { throw ClientError.storage }
        try bytes.write(to: target, options: .atomic)
        try CaptureQueue.protect(target)
    }

    private nonisolated static func stageEpisode(directory: URL, bodyURL: URL, boundary: String) throws {
        let building = bodyURL.deletingPathExtension().appendingPathExtension("building")
        if FileManager.default.fileExists(atPath: building.path) { try FileManager.default.removeItem(at: building) }
        defer { try? FileManager.default.removeItem(at: building) }
        guard FileManager.default.createFile(atPath: building.path, contents: nil,
            attributes: [.protectionKey: FileProtectionType.completeUntilFirstUserAuthentication]) else { throw ClientError.storage }
        let destination = try FileHandle(forWritingTo: building)
        defer { try? destination.close() }
        for (name, filename, contentType) in [("video", "video.mp4", "video/mp4"), ("imu", "imu.jsonl", "application/x-ndjson"),
                                               ("poses", "poses.jsonl", "application/x-ndjson"), ("manifest", "manifest.json", "application/json")] {
            try destination.write(contentsOf: Data("--\(boundary)\r\nContent-Disposition: form-data; name=\"\(name)\"; filename=\"\(filename)\"\r\nContent-Type: \(contentType)\r\n\r\n".utf8))
            let source = try FileHandle(forReadingFrom: directory.appendingPathComponent(filename))
            defer { try? source.close() }
            while let chunk = try source.read(upToCount: 1024 * 1024), !chunk.isEmpty { try destination.write(contentsOf: chunk) }
            try source.close()
            try destination.write(contentsOf: Data("\r\n".utf8))
        }
        try destination.write(contentsOf: Data("--\(boundary)--\r\n".utf8))
        try destination.synchronize()
        try destination.close()
        try FileManager.default.moveItem(at: building, to: bodyURL)
    }

    func upload(file: URL, captureID: UUID, token: String,
                progress: @escaping @MainActor @Sendable (Int64, Int64) -> Void) async throws -> MediaReceipt {
        let attributes = try FileManager.default.attributesOfItem(atPath: file.path)
        guard let size = attributes[.size] as? NSNumber, size.int64Value > 0 else { throw ClientError.invalidResponse }
        guard size.int64Value <= 200 * 1024 * 1024 else { throw ClientError.uploadTooLarge }
        let boundary = "TMT-\(captureID.uuidString)"
        let directory = BackgroundUploads.stagingDirectory
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        try CaptureQueue.protect(directory)
        let bodyURL = directory.appendingPathComponent(captureID.uuidString + ".multipart")
        // Stage on disk; don't put an entire 200 MiB video into memory.
        let alreadyStaged = FileManager.default.fileExists(atPath: bodyURL.path)
        if !alreadyStaged {
            try await Task.detached(priority: .utility) {
                try Self.stage(file: file, bodyURL: bodyURL, boundary: boundary)
            }.value
        }
        var request = URLRequest(url: configuration.endpoint("api/v1/media"))
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue(captureID.uuidString, forHTTPHeaderField: "Idempotency-Key")
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        defer { try? FileManager.default.removeItem(at: bodyURL) }
        let (data, response) = try await transport.upload(for: request, from: bodyURL, progress: progress)
        try? FileManager.default.removeItem(at: bodyURL)
        guard response.url == request.url else { throw ClientError.invalidResponse }
        return try decode(data, response, expected: 202)
    }

    private nonisolated static func stage(file: URL, bodyURL: URL, boundary: String) throws {
        let building = bodyURL.deletingPathExtension().appendingPathExtension("building")
        if FileManager.default.fileExists(atPath: building.path) { try FileManager.default.removeItem(at: building) }
        defer { try? FileManager.default.removeItem(at: building) }
        guard FileManager.default.createFile(atPath: building.path, contents: nil,
                                            attributes: [.protectionKey: FileProtectionType.completeUntilFirstUserAuthentication]) else { throw ClientError.storage }
        let destination = try FileHandle(forWritingTo: building)
        defer { try? destination.close() }
        let source = try FileHandle(forReadingFrom: file)
        defer { try? source.close() }
        try destination.write(contentsOf: Data("--\(boundary)\r\nContent-Disposition: form-data; name=\"file\"; filename=\"pickup.mov\"\r\nContent-Type: video/quicktime\r\n\r\n".utf8))
        while let chunk = try source.read(upToCount: 1024 * 1024), !chunk.isEmpty { try destination.write(contentsOf: chunk) }
        try destination.write(contentsOf: Data("\r\n--\(boundary)--\r\n".utf8))
        try destination.synchronize()
        try destination.close()
        try source.close()
        try FileManager.default.moveItem(at: building, to: bodyURL)
    }

    private func decode<T: Decodable>(_ data: Data, _ response: HTTPURLResponse, expected: Int) throws -> T {
        if response.statusCode != expected {
            let code = (try? JSONDecoder().decode(Failure.self, from: data))?.detail.code
            switch response.statusCode {
            case 401: throw ClientError.unauthorized(code ?? "unknown")
            case 400 where code == "invite_invalid": throw ClientError.invitationInvalid
            case 400 where code == "upload_empty": throw ClientError.uploadEmpty
            case 429:
                if code == "quota_exceeded" { throw ClientError.quotaExceeded }
                let header = response.value(forHTTPHeaderField: "Retry-After") ?? "30"
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.timeZone = TimeZone(secondsFromGMT: 0)
                formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss z"
                let seconds = Double(header) ?? formatter.date(from: header)?.timeIntervalSinceNow ?? 30
                throw ClientError.rateLimited(max(0, min(seconds, 86400)))
            case 413: throw ClientError.uploadTooLarge
            case 415: throw ClientError.unsupportedMedia
            case 422: throw ClientError.validation
            case 404: throw ClientError.missingMedia
            case 403 where code == "development_required": throw ClientError.developmentRequired
            case 409 where code == "capture_processing": throw ClientError.captureProcessing
            case 409 where code == "transfer_incomplete": throw ClientError.server
            case 409: throw ClientError.idempotencyConflict
            case 500...599: throw ClientError.server
            default: throw ClientError.invalidResponse
            }
        }
        guard response.value(forHTTPHeaderField: "Content-Type")?.split(separator: ";").first?
            .trimmingCharacters(in: .whitespaces).lowercased() == "application/json",
              let result = try? JSONDecoder().decode(T.self, from: data) else { throw ClientError.invalidResponse }
        return result
    }
}
