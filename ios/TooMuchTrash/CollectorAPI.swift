import Foundation

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
    func endSession(refreshToken: String) async throws -> EndSessionReceipt
    func media(id: UUID, token: String) async throws -> MediaReceipt
    func adminReachable() async -> Bool
    func availableServers() async throws -> [AvailableServer]
}

extension CollectorAPI {
    func availableServers() async throws -> [AvailableServer] { [] }
    func upload(file: URL, captureID: UUID, token: String,
                progress: @escaping @MainActor @Sendable (Int64, Int64) -> Void) async throws -> MediaReceipt {
        try await upload(file: file, token: token)
    }
    func uploaded(captureID: UUID, token: String) async throws -> MediaReceipt { throw ClientError.missingMedia }
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
