import Foundation
import Security
import XCTest
@testable import TooMuchTrash

@MainActor
private final class MemoryVault: CredentialVault {
    var values: [URL: InstallationCredential] = [:]
    var failSave = false
    var failLoad = false
    var saves = 0
    func load(origin: URL) throws -> InstallationCredential? {
        if failLoad { throw ClientError.storage }
        return values[origin]
    }
    func save(_ credential: InstallationCredential, origin: URL) throws {
        if failSave { throw ClientError.storage }
        saves += 1
        values[origin] = credential
    }
}

@MainActor
private final class StubAPI: CollectorAPI {
    let id = UUID()
    var meErrors: [Error] = []
    var refreshError: Error?
    var enrollError: Error?
    var uploadError: Error?
    var meCalls = 0
    var refreshCalls = 0
    var enrollCalls = 0
    var uploadCalls = 0
    var reachable = false
    var confirmedID: UUID?
    var delayProbe = false
    var probeContinuation: CheckedContinuation<Bool, Never>?
    var tokensSeen: [String] = []

    var enrollment: Enrollment {
        Enrollment(installationID: id, accessToken: "test-access", refreshToken: "test-refresh",
                   tokenType: "Bearer", expiresIn: 900, refreshExpiresIn: 2592000)
    }
    func enroll(invite: String, name: String?) async throws -> Enrollment {
        enrollCalls += 1
        if let enrollError { throw enrollError }
        return enrollment
    }
    func refresh(token: String) async throws -> AccessToken {
        refreshCalls += 1
        if let refreshError { throw refreshError }
        return AccessToken(accessToken: "test-refreshed", tokenType: "Bearer", expiresIn: 900)
    }
    func me(token: String) async throws -> Installation {
        meCalls += 1
        tokensSeen.append(token)
        if !meErrors.isEmpty { throw meErrors.removeFirst() }
        return Installation(installationID: confirmedID ?? id, installationName: "Test iPhone",
                            quotaBytes: 1000000, quotaUploads: 10, usedBytes: 0, usedUploads: 0)
    }
    func upload(file: URL, token: String) async throws -> MediaReceipt {
        uploadCalls += 1
        if let uploadError { throw uploadError }
        return MediaReceipt(id: UUID(), status: "queued", filename: "pickup.mov", sizeBytes: 10)
    }
    func media(id: UUID, token: String) async throws -> MediaReceipt {
        MediaReceipt(id: id, status: "completed", filename: "pickup.mov", sizeBytes: 10)
    }
    func adminReachable() async -> Bool {
        if delayProbe { return await withCheckedContinuation { probeContinuation = $0 } }
        return reachable
    }
}

@MainActor
final class OnboardingTests: XCTestCase {
    private let origin = URL(string: "https://collector.example.test")!
    private func configuration() throws -> APIConfiguration {
        try APIConfiguration(publicURL: origin.absoluteString, privateAdminURL: "https://admin.example.test:8443")
    }
    private func queueDirectory() -> URL {
        FileManager.default.temporaryDirectory.appendingPathComponent("tmt-tests-\(UUID().uuidString)")
    }
    private func account(_ api: StubAPI, _ vault: MemoryVault, queue: CaptureQueue? = nil) throws -> AccountSession {
        AccountSession(configuration: try configuration(), vault: vault,
                       queue: queue ?? CaptureQueue(directory: queueDirectory()), apiFactory: { _ in api })
    }
    private func seed(_ api: StubAPI, _ vault: MemoryVault, expired: Bool = false) throws {
        var credential = try InstallationCredential(enrollment: api.enrollment)
        if expired { credential.accessExpiresAt = .distantPast }
        vault.values[origin] = credential
    }

    func testNoCredentialDoesNotAuthorizeOrCallMe() async throws {
        let api = StubAPI(), vault = MemoryVault()
        let session = try account(api, vault)
        await session.bootstrap()
        XCTAssertEqual(session.phase, .home)
        XCTAssertEqual(api.meCalls, 0)
        await session.continueLogin()
        XCTAssertEqual(session.phase, .home)
    }

    func testConfiguringFirstServerUpdatesHomeInstructions() async throws {
        let keys = ["collectorPublicOrigin", "privateAdminOrigin"]
        let previous = keys.map { UserDefaults.standard.object(forKey: $0) }
        defer {
            for (key, value) in zip(keys, previous) {
                if let value { UserDefaults.standard.set(value, forKey: key) }
                else { UserDefaults.standard.removeObject(forKey: key) }
            }
        }
        let api = StubAPI(), vault = MemoryVault()
        let session = AccountSession(configuration: nil, vault: vault,
                                     queue: CaptureQueue(directory: queueDirectory()), apiFactory: { _ in api })
        XCTAssertEqual(session.message, "Set the collector server address to get started.")
        await session.configure(try configuration())
        XCTAssertEqual(session.message, "Register with an invite to begin collecting.")
        XCTAssertEqual(session.phase, .home)
        XCTAssertEqual(api.meCalls, 0)
    }

    func testSavedCredentialMustBeValidated() async throws {
        let api = StubAPI(), vault = MemoryVault()
        try seed(api, vault)
        let session = try account(api, vault)
        XCTAssertEqual(session.phase, .home)
        await session.bootstrap()
        XCTAssertEqual(session.phase, .authorized)
        XCTAssertEqual(api.meCalls, 1)
        XCTAssertEqual(session.installation?.installationID, api.id)
    }

    func testOfflinePreservesCredentialsAndRetrySucceeds() async throws {
        let api = StubAPI(), vault = MemoryVault()
        try seed(api, vault)
        api.meErrors = [URLError(.notConnectedToInternet)]
        let session = try account(api, vault)
        await session.bootstrap()
        XCTAssertEqual(session.phase, .retry)
        XCTAssertNotNil(vault.values[origin])
        XCTAssertEqual(vault.saves, 0)
        await session.continueLogin()
        XCTAssertEqual(session.phase, .authorized)
    }

    func testRevokedCredentialDoesNotRefreshOrDelete() async throws {
        let api = StubAPI(), vault = MemoryVault()
        try seed(api, vault)
        api.meErrors = [ClientError.unauthorized("access_revoked")]
        let session = try account(api, vault)
        await session.bootstrap()
        XCTAssertEqual(session.phase, .needsInvite)
        XCTAssertEqual(api.refreshCalls, 0)
        XCTAssertNotNil(vault.values[origin])
    }

    func testExpiredAccessRefreshesAndPersistsBeforeValidation() async throws {
        let api = StubAPI(), vault = MemoryVault()
        try seed(api, vault, expired: true)
        let session = try account(api, vault)
        await session.bootstrap()
        XCTAssertEqual(session.phase, .authorized)
        XCTAssertEqual(api.refreshCalls, 1)
        XCTAssertEqual(api.tokensSeen, ["test-refreshed"])
        XCTAssertEqual(vault.values[origin]?.accessToken, "test-refreshed")
    }

    func testInvalidRefreshRequiresInviteAndRetainsOriginal() async throws {
        let api = StubAPI(), vault = MemoryVault()
        try seed(api, vault, expired: true)
        api.refreshError = ClientError.unauthorized("refresh_invalid")
        let session = try account(api, vault)
        await session.bootstrap()
        XCTAssertEqual(session.phase, .needsInvite)
        XCTAssertEqual(vault.values[origin]?.accessToken, "test-access")
    }

    func testAccessInvalidRefreshesOnceOnly() async throws {
        let api = StubAPI(), vault = MemoryVault()
        try seed(api, vault)
        api.meErrors = [ClientError.unauthorized("access_invalid"), ClientError.unauthorized("access_invalid")]
        let session = try account(api, vault)
        await session.bootstrap()
        XCTAssertEqual(api.refreshCalls, 1)
        XCTAssertEqual(api.meCalls, 2)
        XCTAssertEqual(session.phase, .needsInvite)
    }

    func testRefreshNetworkFailureIsRetryable() async throws {
        let api = StubAPI(), vault = MemoryVault()
        try seed(api, vault, expired: true)
        api.refreshError = URLError(.timedOut)
        let session = try account(api, vault)
        await session.bootstrap()
        XCTAssertEqual(session.phase, .retry)
        XCTAssertNotNil(vault.values[origin])
    }

    func testSuccessfulEnrollmentStoresAndValidates() async throws {
        let api = StubAPI(), vault = MemoryVault()
        let session = try account(api, vault)
        let result = await session.register(invite: "test-invite", name: "Field iPhone")
        XCTAssertTrue(result)
        XCTAssertEqual(vault.saves, 1)
        XCTAssertEqual(api.meCalls, 1)
        XCTAssertEqual(session.phase, .authorized)
    }

    func testInvalidInviteDoesNotStore() async throws {
        let api = StubAPI(), vault = MemoryVault()
        api.enrollError = ClientError.invitationInvalid
        let session = try account(api, vault)
        let result = await session.register(invite: "test-invite", name: "")
        XCTAssertFalse(result)
        XCTAssertEqual(vault.saves, 0)
        XCTAssertEqual(api.meCalls, 0)
        XCTAssertFalse(session.message.contains("may have been consumed"))
    }

    func testLostEnrollmentResponseWarnsAndDoesNotRetry() async throws {
        let api = StubAPI(), vault = MemoryVault()
        api.enrollError = URLError(.networkConnectionLost)
        let session = try account(api, vault)
        let result = await session.register(invite: "test-invite", name: "")
        XCTAssertFalse(result)
        XCTAssertEqual(api.enrollCalls, 1)
        XCTAssertEqual(vault.saves, 0)
        XCTAssertTrue(session.message.contains("may have been consumed"))
    }

    func testFailedKeychainWriteDoesNotAuthorize() async throws {
        let api = StubAPI(), vault = MemoryVault()
        vault.failSave = true
        let session = try account(api, vault)
        let result = await session.register(invite: "test-invite", name: "")
        XCTAssertFalse(result)
        XCTAssertEqual(session.phase, .retry)
        XCTAssertEqual(api.meCalls, 0)
        XCTAssertTrue(session.message.contains("may have consumed"))
    }

    func testKeychainReadFailureIsNotMistakenForMissingCredential() async throws {
        let api = StubAPI(), vault = MemoryVault()
        vault.failLoad = true
        let session = try account(api, vault)
        await session.bootstrap()
        XCTAssertEqual(session.phase, .retry)
        XCTAssertEqual(api.meCalls, 0)
    }

    func testMismatchedInstallationIdentityDoesNotAuthorize() async throws {
        let api = StubAPI(), vault = MemoryVault()
        try seed(api, vault)
        api.confirmedID = UUID()
        let session = try account(api, vault)
        await session.bootstrap()
        XCTAssertEqual(session.phase, .retry)
        XCTAssertNil(session.installation)
    }

    func testAdminHiddenUntilPrivateReachabilityAndHiddenOnSuspension() async throws {
        let api = StubAPI(), vault = MemoryVault()
        let session = try account(api, vault)
        XCTAssertFalse(session.adminVisible)
        await session.probeAdmin()
        XCTAssertFalse(session.adminVisible)
        api.reachable = true
        await session.probeAdmin()
        XCTAssertTrue(session.adminVisible)
        session.hideAdmin()
        XCTAssertFalse(session.adminVisible)
        api.reachable = false
        let destination = await session.verifiedAdminURL()
        XCTAssertNil(destination)
    }

    func testOfflineUploadRetainsQueueFileAndCredentials() async throws {
        let api = StubAPI(), vault = MemoryVault()
        try seed(api, vault)
        let directory = queueDirectory()
        let queue = CaptureQueue(directory: directory)
        let file = directory.appendingPathComponent("pickup.mov")
        try Data("test-video".utf8).write(to: file)
        let session = try account(api, vault, queue: queue)
        await session.bootstrap()
        session.queueCapture(file, owner: session.captureOwner)
        api.uploadError = URLError(.notConnectedToInternet)
        await session.uploadPending()
        XCTAssertEqual(session.phase, .retry)
        XCTAssertEqual(queue.captures.count, 1)
        XCTAssertNil(queue.captures[0].receipt)
        XCTAssertTrue(FileManager.default.fileExists(atPath: file.path))
        XCTAssertNotNil(vault.values[origin])
        let restored = CaptureQueue(directory: directory)
        XCTAssertEqual(restored.captures, queue.captures)
    }

    func testSuccessfulUploadIsNotSentAgainAndRetainsLocalFile() async throws {
        let api = StubAPI(), vault = MemoryVault()
        try seed(api, vault)
        let directory = queueDirectory(), queue = CaptureQueue(directory: directory)
        let file = directory.appendingPathComponent("pickup.mov")
        try Data("test-video".utf8).write(to: file)
        let session = try account(api, vault, queue: queue)
        await session.bootstrap()
        session.queueCapture(file, owner: session.captureOwner)
        await session.uploadPending()
        await session.uploadPending()
        XCTAssertEqual(api.uploadCalls, 1)
        XCTAssertNotNil(queue.captures[0].receipt)
        XCTAssertTrue(FileManager.default.fileExists(atPath: file.path))
        await session.refreshUploadStatus()
        XCTAssertEqual(queue.captures[0].receipt?.status, "completed")
    }

    func testOldInstallationAndOriginQueueEntriesAreNeverUploaded() async throws {
        let api = StubAPI(), vault = MemoryVault()
        try seed(api, vault)
        let directory = queueDirectory(), queue = CaptureQueue(directory: directory)
        let file = directory.appendingPathComponent("pickup.mov")
        try Data("test-video".utf8).write(to: file)
        try queue.enqueue(file: file, origin: origin, installationID: UUID())
        let session = try account(api, vault, queue: queue)
        await session.bootstrap()
        await session.uploadPending()
        XCTAssertEqual(api.uploadCalls, 0)
        XCTAssertEqual(queue.captures.count, 1)
        XCTAssertTrue(queue.matching(origin: URL(string: "https://other.example.test")!, installationID: api.id).isEmpty)
    }

    func testRateLimitBlocksImmediateEnrollmentRetry() async throws {
        let api = StubAPI(), vault = MemoryVault()
        api.enrollError = ClientError.rateLimited(60)
        let session = try account(api, vault)
        _ = await session.register(invite: "test-invite", name: "")
        XCTAssertNotNil(session.retryNotBefore)
        XCTAssertFalse(session.message.contains("may have been consumed"))
        _ = await session.register(invite: "test-invite", name: "")
        XCTAssertEqual(api.enrollCalls, 1)
        XCTAssertEqual(vault.saves, 0)
    }

    func testInFlightAdminProbeCannotShowButtonAfterSuspension() async throws {
        let api = StubAPI(), vault = MemoryVault()
        api.delayProbe = true
        let session = try account(api, vault)
        let probe = Task { await session.probeAdmin() }
        while api.probeContinuation == nil { await Task.yield() }
        session.suspend()
        api.probeContinuation?.resume(returning: true)
        await probe.value
        XCTAssertFalse(session.adminVisible)
    }

    func testRevokedUploadRetainsQueueAndDoesNotRefresh() async throws {
        let api = StubAPI(), vault = MemoryVault()
        try seed(api, vault)
        let directory = queueDirectory(), queue = CaptureQueue(directory: directory)
        let file = directory.appendingPathComponent("pickup.mov")
        try Data("test-video".utf8).write(to: file)
        let session = try account(api, vault, queue: queue)
        await session.bootstrap()
        session.queueCapture(file, owner: session.captureOwner)
        api.uploadError = ClientError.unauthorized("access_revoked")
        await session.uploadPending()
        XCTAssertEqual(session.phase, .needsInvite)
        XCTAssertEqual(api.refreshCalls, 0)
        XCTAssertNil(queue.captures[0].receipt)
        XCTAssertNotNil(vault.values[origin])
        XCTAssertTrue(FileManager.default.fileExists(atPath: file.path))
    }

    func testLateRecordingCompletionRetainsOriginalOwner() async throws {
        let api = StubAPI(), vault = MemoryVault()
        try seed(api, vault)
        let directory = queueDirectory(), queue = CaptureQueue(directory: directory)
        let file = directory.appendingPathComponent("pickup.mov")
        try Data("test-video".utf8).write(to: file)
        let session = try account(api, vault, queue: queue)
        await session.bootstrap()
        let owner = session.captureOwner
        session.returnHome()
        session.queueCapture(file, owner: owner)
        XCTAssertEqual(queue.captures[0].installationID, api.id)
    }

    func testCorruptQueueIsNotOverwritten() throws {
        let directory = queueDirectory()
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        let manifest = directory.appendingPathComponent("upload-queue.json")
        let original = Data("invalid-json".utf8)
        try original.write(to: manifest)
        let queue = CaptureQueue(directory: directory)
        let file = directory.appendingPathComponent("pickup.mov")
        try Data("test-video".utf8).write(to: file)
        XCTAssertTrue(queue.storageUnavailable)
        XCTAssertThrowsError(try queue.enqueue(file: file, origin: origin, installationID: UUID()))
        XCTAssertEqual(try Data(contentsOf: manifest), original)
    }

    func testRealKeychainRoundtripUpdateAndOriginIsolation() throws {
        let service = "org.toomuchtrash.tests.\(UUID().uuidString)"
        let vault = KeychainCredentialVault(service: service)
        defer {
            // Delete only this test's unique namespace, never app credentials.
            SecItemDelete([kSecClass as String: kSecClassGenericPassword,
                           kSecAttrService as String: service] as CFDictionary)
        }
        let api = StubAPI()
        var credential = try InstallationCredential(enrollment: api.enrollment)
        XCTAssertNil(try vault.load(origin: origin))
        try vault.save(credential, origin: origin)
        XCTAssertEqual(try KeychainCredentialVault(service: service).load(origin: origin), credential)
        credential.accessToken = "test-updated"
        try vault.save(credential, origin: origin)
        XCTAssertEqual(try vault.load(origin: origin), credential)
        XCTAssertNil(try vault.load(origin: URL(string: "https://other.example.test")!))
        var attributes: CFTypeRef?
        let status = SecItemCopyMatching([
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: origin.absoluteString,
            kSecReturnAttributes as String: true
        ] as CFDictionary, &attributes)
        XCTAssertEqual(status, errSecSuccess)
        let result = try XCTUnwrap(attributes as? [String: Any])
        XCTAssertEqual(result[kSecAttrAccessible as String] as? String,
                       kSecAttrAccessibleWhenUnlockedThisDeviceOnly as String)
        XCTAssertNotEqual(result[kSecAttrSynchronizable as String] as? Bool, true)
    }
}
