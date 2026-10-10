import Foundation

struct APIConfiguration: Equatable {
    let publicOrigin: URL
    let privateAdminOrigin: URL?

    init(publicURL: String, privateAdminURL: String = "") throws {
        publicOrigin = try Self.origin(publicURL)
        privateAdminOrigin = privateAdminURL.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            ? nil : try Self.origin(privateAdminURL)
        guard privateAdminOrigin != publicOrigin else { throw ClientError.configuration }
    }

    private static func origin(_ string: String) throws -> URL {
        guard var parts = URLComponents(string: string.trimmingCharacters(in: .whitespacesAndNewlines)),
              parts.scheme?.lowercased() == "https", let host = parts.host, !host.isEmpty,
              parts.user == nil, parts.password == nil, parts.query == nil, parts.fragment == nil,
              parts.path.isEmpty || parts.path == "/",
              parts.port == nil || (1...65535).contains(parts.port!) else {
            throw ClientError.configuration
        }
        parts.scheme = "https"
        parts.host = host.lowercased()
        parts.path = ""
        if parts.port == 443 { parts.port = nil }
        guard let url = parts.url else { throw ClientError.configuration }
        return url
    }

    func endpoint(_ path: String) -> URL { publicOrigin.appendingPathComponent(path) }

    static func saved(defaults: UserDefaults = .standard) -> APIConfiguration? {
        guard let publicURL = defaults.string(forKey: "collectorPublicOrigin") else { return nil }
        return try? APIConfiguration(publicURL: publicURL,
                                     privateAdminURL: defaults.string(forKey: "privateAdminOrigin") ?? "")
    }

    func save(defaults: UserDefaults = .standard) {
        // Only non-secret origins go into preferences. Tokens and invites never do.
        defaults.set(publicOrigin.absoluteString, forKey: "collectorPublicOrigin")
        defaults.set(privateAdminOrigin?.absoluteString, forKey: "privateAdminOrigin")
    }
}

enum ClientError: Error, Equatable {
    case configuration, storage, invalidResponse, network, server
    case noCredential, invitationInvalid, unauthorized(String), uploadTooLarge
    case rateLimited(TimeInterval)
    case quotaExceeded, missingMedia, validation, unsupportedMedia, uploadEmpty

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
    enum CodingKeys: String, CodingKey {
        case installationID = "installation_id", installationName = "installation_name"
        case quotaBytes = "quota_bytes", quotaUploads = "quota_uploads"
        case usedBytes = "used_bytes", usedUploads = "used_uploads"
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
    enum CodingKeys: String, CodingKey {
        case id, status, filename, sizeBytes = "size_bytes"
    }
}
