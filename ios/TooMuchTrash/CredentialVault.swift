import Foundation
import Security

@MainActor
protocol CredentialVault {
    func load(origin: URL) throws -> InstallationCredential?
    func save(_ credential: InstallationCredential, origin: URL) throws
}

@MainActor
final class KeychainCredentialVault: CredentialVault {
    private let service: String
    init(service: String = "org.toomuchtrash.installation") { self.service = service }

    private func query(origin: URL) -> [String: Any] {
        [kSecClass as String: kSecClassGenericPassword,
         kSecAttrService as String: service,
         kSecAttrAccount as String: origin.absoluteString,
         kSecAttrSynchronizable as String: false]
    }

    func load(origin: URL) throws -> InstallationCredential? {
        var request = query(origin: origin)
        request[kSecReturnData as String] = true
        request[kSecMatchLimit as String] = kSecMatchLimitOne
        var result: CFTypeRef?
        let status = SecItemCopyMatching(request as CFDictionary, &result)
        if status == errSecItemNotFound { return nil }
        guard status == errSecSuccess, let data = result as? Data,
              let credential = try? JSONDecoder().decode(InstallationCredential.self, from: data) else {
            throw ClientError.storage
        }
        return credential
    }

    func save(_ credential: InstallationCredential, origin: URL) throws {
        let data = try JSONEncoder().encode(credential)
        let attributes: [String: Any] = [
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlockedThisDeviceOnly
        ]
        let base = query(origin: origin)
        let update = SecItemUpdate(base as CFDictionary, attributes as CFDictionary)
        if update == errSecSuccess { return }
        guard update == errSecItemNotFound else { throw ClientError.storage }
        let insert = base.merging(attributes) { _, new in new }
        guard SecItemAdd(insert as CFDictionary, nil) == errSecSuccess else { throw ClientError.storage }
    }
}
