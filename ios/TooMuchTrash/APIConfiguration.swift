import Foundation

struct APIConfiguration: Equatable {
    let publicOrigin: URL
    let privateAdminOrigin: URL?
    let simulatorLocal: Bool

    static var supportsSimulatorLocal: Bool {
        #if DEBUG && targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }

    init(publicURL: String, privateAdminURL: String = "", simulatorLocal: Bool = false) throws {
        guard !simulatorLocal || Self.supportsSimulatorLocal else { throw ClientError.configuration }
        self.simulatorLocal = simulatorLocal
        publicOrigin = try Self.origin(publicURL, simulatorLocal: simulatorLocal)
        privateAdminOrigin = privateAdminURL.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            ? nil : try Self.origin(privateAdminURL, simulatorLocal: simulatorLocal,
                                    allowHTTPS: true)
        guard privateAdminOrigin != publicOrigin else { throw ClientError.configuration }
    }

    private static func origin(_ string: String, simulatorLocal: Bool, allowHTTPS: Bool = false) throws -> URL {
        guard var parts = URLComponents(string: string.trimmingCharacters(in: .whitespacesAndNewlines)),
              let host = parts.host, !host.isEmpty,
              parts.user == nil, parts.password == nil, parts.query == nil, parts.fragment == nil,
              parts.path.isEmpty || parts.path == "/",
              parts.port == nil || (1...65535).contains(parts.port!) else {
            throw ClientError.configuration
        }
        let scheme = parts.scheme?.lowercased()
        if simulatorLocal {
            guard (scheme == "http" && host.lowercased() == "localhost") ||
                    (allowHTTPS && scheme == "https") else { throw ClientError.configuration }
        } else {
            guard scheme == "https" else { throw ClientError.configuration }
        }
        parts.scheme = scheme
        parts.host = host.lowercased()
        parts.path = ""
        if parts.port == (scheme == "http" ? 80 : 443) { parts.port = nil }
        guard let url = parts.url else { throw ClientError.configuration }
        return url
    }

    func endpoint(_ path: String) -> URL { publicOrigin.appendingPathComponent(path) }

    static func saved(defaults: UserDefaults = .standard) -> APIConfiguration? {
        guard let publicURL = defaults.string(forKey: "collectorPublicOrigin") else { return nil }
        return try? APIConfiguration(publicURL: publicURL,
                                     privateAdminURL: defaults.string(forKey: "privateAdminOrigin") ?? "",
                                     simulatorLocal: defaults.bool(forKey: "simulatorLocalBackend"))
    }

    func save(defaults: UserDefaults = .standard) {
        // Only non-secret origins go into preferences. Tokens and invites never do.
        defaults.set(publicOrigin.absoluteString, forKey: "collectorPublicOrigin")
        defaults.set(privateAdminOrigin?.absoluteString, forKey: "privateAdminOrigin")
        defaults.set(simulatorLocal, forKey: "simulatorLocalBackend")
        // Retain the designated HTTPS network probe when collector mode changes.
        rememberAdminNetwork(defaults: defaults)
    }

    func rememberAdminNetwork(defaults: UserDefaults = .standard) {
        if !simulatorLocal, let privateAdminOrigin {
            defaults.set(publicOrigin.absoluteString, forKey: "adminNetworkCollectorOrigin")
            defaults.set(privateAdminOrigin.absoluteString, forKey: "adminNetworkPrivateOrigin")
        }
    }

    static func savedAdminNetwork(defaults: UserDefaults = .standard) -> APIConfiguration? {
        guard let collector = defaults.string(forKey: "adminNetworkCollectorOrigin"),
              let admin = defaults.string(forKey: "adminNetworkPrivateOrigin") else { return nil }
        return try? APIConfiguration(publicURL: collector, privateAdminURL: admin)
    }

    static var localCollector: APIConfiguration? {
        guard supportsSimulatorLocal else { return nil }
        return try? APIConfiguration(publicURL: "http://localhost:8082",
                                     privateAdminURL: developmentAdminURL, simulatorLocal: true)
    }

    static let developmentCollectorURL = "https://too-much-trash-eric-dev.mongoose-bonito.ts.net:10000"
    static let developmentAdminURL = "https://too-much-trash-eric-dev.mongoose-bonito.ts.net:8443"
    static var developmentNetwork: APIConfiguration {
        // Non-secret preset for this prototype. Saved origins always take precedence.
        try! APIConfiguration(publicURL: developmentCollectorURL, privateAdminURL: developmentAdminURL)
    }
}

enum ClientError: Error, Equatable {
    case configuration, storage, invalidResponse, network, server
    case noCredential, invitationInvalid, unauthorized(String), uploadTooLarge
    case rateLimited(TimeInterval)
    case quotaExceeded, missingMedia, validation, unsupportedMedia, uploadEmpty
    case idempotencyConflict

    var message: String {
        switch self {
        case .configuration: return "Enter separate HTTPS server origins without paths, passwords, queries, or fragments."
        case .storage: return "Secure storage is unavailable. Unlock the iPhone and retry."
        case .invalidResponse: return "The server response could not be verified. Please retry."
        case .network: return "Unable to reach the server. Check your connection and retry."
        case .server: return "The server is temporarily unavailable. Please retry."
        case .noCredential: return "Register with an invite from your administrator first."
        case .invitationInvalid: return "This invite is invalid, expired, or already used. Ask your administrator for a new invite."
        case .unauthorized: return "Access was rejected or revoked. Contact your administrator or register with a new invite."
        case .uploadTooLarge: return "This video exceeds the 200 MiB upload limit. It remains on this iPhone."
        case .rateLimited: return "Too many requests. Wait before retrying; your files are retained."
        case .quotaExceeded: return "Your upload quota is reached. Contact your administrator; your files are retained."
        case .missingMedia: return "This server capture is unavailable. The local video is retained."
        case .validation: return "The server rejected these values. Check the invite and installation name."
        case .unsupportedMedia: return "This video format is not supported. The local video is retained."
        case .uploadEmpty: return "This video is empty. The local file is retained for review."
        case .idempotencyConflict: return "This video conflicts with a previously accepted upload. Contact your administrator."
        }
    }
}

struct Installation: Codable, Equatable {
    let installationID: UUID
    let installationName: String?
    let quotaBytes: Int64
    let quotaUploads: Int
    let usedBytes: Int64
    let usedUploads: Int
    var mediaContractVersion: Int?
    enum CodingKeys: String, CodingKey {
        case installationID = "installation_id", installationName = "installation_name"
        case quotaBytes = "quota_bytes", quotaUploads = "quota_uploads"
        case usedBytes = "used_bytes", usedUploads = "used_uploads"
        case mediaContractVersion = "media_contract_version"
    }
}

struct Enrollment: Decodable {
    let installationID: UUID
    let accessToken: String
    let refreshToken: String
    let tokenType: String
    let expiresIn: Int
    let refreshExpiresIn: Int
    enum CodingKeys: String, CodingKey {
        case installationID = "installation_id", accessToken = "access_token", refreshToken = "refresh_token"
        case tokenType = "token_type", expiresIn = "expires_in", refreshExpiresIn = "refresh_expires_in"
    }
}

struct AccessToken: Decodable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token", tokenType = "token_type", expiresIn = "expires_in"
    }
}

struct InstallationCredential: Codable, Equatable {
    let installationID: UUID
    var accessToken: String
    let refreshToken: String
    var accessExpiresAt: Date
    let refreshExpiresAt: Date
    var endingSession: Bool?
    var revocationConfirmed: Bool?

    init(enrollment: Enrollment, now: Date = Date()) throws {
        guard enrollment.tokenType == "Bearer", !enrollment.accessToken.isEmpty,
              !enrollment.refreshToken.isEmpty, enrollment.expiresIn > 0,
              enrollment.refreshExpiresIn > 0 else { throw ClientError.invalidResponse }
        installationID = enrollment.installationID
        accessToken = enrollment.accessToken
        refreshToken = enrollment.refreshToken
        accessExpiresAt = now.addingTimeInterval(TimeInterval(enrollment.expiresIn))
        refreshExpiresAt = now.addingTimeInterval(TimeInterval(enrollment.refreshExpiresIn))
    }
}

struct MediaReceipt: Codable, Equatable {
    let id: UUID
    let status: String
    let filename: String
    let sizeBytes: Int64
    var clientCaptureID: UUID?
    enum CodingKeys: String, CodingKey {
        case id, status, filename, sizeBytes = "size_bytes", clientCaptureID = "client_capture_id"
    }
}

struct EndSessionReceipt: Decodable {
    let installationID: UUID
    let revoked: Bool
    enum CodingKeys: String, CodingKey { case installationID = "installation_id", revoked }
}
