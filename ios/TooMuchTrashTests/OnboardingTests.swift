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
    func remove(origin: URL) throws {
        if failSave { throw ClientError.storage }
        values.removeValue(forKey: origin)
    }
}

@MainActor
private final class StubAPI: CollectorAPI {
    let id = UUID()
    var meErrors: [Error] = []
    var refreshError: Error?
    var enrollError: Error?
    var uploadError: Error?
    var endError: Error?
    var endCalls = 0
    var endID: UUID?
    var acceptedUploads: [UUID: MediaReceipt] = [:]
    var meCalls = 0
    var refreshCalls = 0
    var enrollCalls = 0
    var invitesSeen: [String] = []
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
        invitesSeen.append(invite)
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
                            quotaBytes: 1000000, quotaUploads: 10, usedBytes: 0, usedUploads: 0, mediaContractVersion: 1)
    }
    func upload(file: URL, token: String) async throws -> MediaReceipt {
        uploadCalls += 1
        if let uploadError { throw uploadError }
        return MediaReceipt(id: UUID(), status: "queued", filename: "pickup.mov", sizeBytes: 10)
    }
    func upload(file: URL, captureID: UUID, token: String,
                progress: @escaping @MainActor @Sendable (Int64, Int64) -> Void) async throws -> MediaReceipt {
        let prior = try await upload(file: file, token: token)
        let size = (try FileManager.default.attributesOfItem(atPath: file.path)[.size] as? NSNumber)?.int64Value ?? 0
        let receipt = MediaReceipt(id: prior.id, status: prior.status, filename: prior.filename, sizeBytes: size, clientCaptureID: captureID)
        progress(10, 10)
        return receipt
    }
    func media(id: UUID, token: String) async throws -> MediaReceipt {
        MediaReceipt(id: id, status: "completed", filename: "pickup.mov", sizeBytes: 10)
    }
    func uploaded(captureID: UUID, token: String) async throws -> MediaReceipt {
        guard let receipt = acceptedUploads[captureID] else { throw ClientError.missingMedia }
        return receipt
    }
    func endSession(refreshToken: String) async throws -> EndSessionReceipt {
        endCalls += 1
        if let endError { throw endError }
        return EndSessionReceipt(installationID: endID ?? id, revoked: true)
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
        let keys = ["collectorPublicOrigin", "privateAdminOrigin", "simulatorLocalBackend",
                    "adminNetworkCollectorOrigin", "adminNetworkPrivateOrigin"]
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
        XCTAssertEqual(session.message, "Collector server is not configured. Contact your administrator.")
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

    func testInviteWordsArePassedToBackendForNormalization() async throws {
        let api = StubAPI(), vault = MemoryVault()
        let session = try account(api, vault)
        let result = await session.register(invite: "  Abandon\t  ABILITY\n", name: "")
        XCTAssertTrue(result)
        XCTAssertEqual(api.invitesSeen, ["Abandon\t  ABILITY"])
    }

    func testWhitespaceOnlyInviteDoesNotEnroll() async throws {
        let api = StubAPI(), vault = MemoryVault()
        let session = try account(api, vault)
        let result = await session.register(invite: " \t\n", name: "")
        XCTAssertFalse(result)
        XCTAssertEqual(api.enrollCalls, 0)
        XCTAssertEqual(vault.saves, 0)
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

    func testLocalAdminReachabilityCannotGrantNetworkAdminView() async throws {
        guard APIConfiguration.supportsSimulatorLocal else { throw XCTSkip("Debug Simulator only") }
        let local = try APIConfiguration(publicURL: "http://localhost:8082",
            privateAdminURL: "http://localhost:8081", simulatorLocal: true)
        let api = StubAPI(), vault = MemoryVault()
        api.reachable = true
        let session = AccountSession(configuration: local,
                                     vault: vault, queue: CaptureQueue(directory: queueDirectory()),
                                     apiFactory: { _ in api })
        await session.probeAdmin()
        XCTAssertFalse(session.adminVisible)
        let destination = await session.verifiedAdminURL()
        XCTAssertNil(destination)
    }

    func testMixedLocalCollectorUsesHTTPSAdminIdentity() async throws {
        guard let local = APIConfiguration.localCollector else { throw XCTSkip("Debug Simulator only") }
        let api = StubAPI()
        api.reachable = true
        let session = AccountSession(configuration: local, vault: MemoryVault(),
            queue: CaptureQueue(directory: queueDirectory()), apiFactory: { _ in api })
        await session.probeAdmin()
        XCTAssertTrue(session.adminVisible)
        let destination = await session.verifiedAdminURL()
        XCTAssertEqual(destination, local.privateAdminOrigin)
        api.reachable = false
        let denied = await session.verifiedAdminURL()
        XCTAssertNil(denied)
    }

    func testNetworkLossFallsBackWithoutReassigningCredentialsAndRecoversMenus() async throws {
        guard APIConfiguration.supportsSimulatorLocal else { throw XCTSkip("Debug Simulator only") }
        let keys = ["collectorPublicOrigin", "privateAdminOrigin", "simulatorLocalBackend",
                    "adminNetworkCollectorOrigin", "adminNetworkPrivateOrigin"]
        let previous = keys.map { UserDefaults.standard.object(forKey: $0) }
        defer {
            for (key, value) in zip(keys, previous) {
                if let value { UserDefaults.standard.set(value, forKey: key) }
                else { UserDefaults.standard.removeObject(forKey: key) }
            }
        }
        let api = StubAPI(), vault = MemoryVault()
        try seed(api, vault)
        api.reachable = true
        let remote = try configuration()
        let session = AccountSession(configuration: remote, vault: vault,
                                     queue: CaptureQueue(directory: queueDirectory()),
                                     automaticallyUseLocalCollector: true, apiFactory: { _ in api })
        await session.bootstrap()
        XCTAssertTrue(session.adminVisible)
        api.reachable = false
        await session.probeAdmin()
        XCTAssertFalse(session.adminVisible)
        XCTAssertEqual(session.configuration, remote)
        XCTAssertEqual(session.phase, .authorized)
        XCTAssertNotNil(session.captureOwner)
        XCTAssertNotNil(vault.values[origin])
        XCTAssertEqual(session.adminNetworkConfiguration, remote)
        XCTAssertEqual(APIConfiguration.savedAdminNetwork(), remote)
        api.reachable = true
        await session.probeAdmin()
        XCTAssertTrue(session.adminVisible)
        let destination = await session.verifiedAdminURL()
        XCTAssertEqual(destination, remote.privateAdminOrigin)
        XCTAssertEqual(session.configuration, remote)
    }

    func testLocalAdminHandoffRequiresNetworkAndLocalIdentity() async throws {
        guard let local = APIConfiguration.localCollector else { throw XCTSkip("Debug Simulator only") }
        let networkAPI = StubAPI(), localAPI = StubAPI()
        networkAPI.reachable = true
        let session = AccountSession(configuration: local, vault: MemoryVault(),
                                     queue: CaptureQueue(directory: queueDirectory()),
                                     adminNetworkConfiguration: try configuration(),
                                     apiFactory: { $0.simulatorLocal ? localAPI : networkAPI })
        await session.probeAdmin()
        XCTAssertTrue(session.adminVisible)
        let unavailable = await session.verifiedAdminURL()
        XCTAssertNil(unavailable)
        localAPI.reachable = true
        let destination = await session.verifiedAdminURL()
        XCTAssertEqual(destination, local.privateAdminOrigin)
        XCTAssertTrue(session.adminVisible)
        networkAPI.reachable = false
        let denied = await session.verifiedAdminURL()
        XCTAssertNil(denied)
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
        XCTAssertEqual(session.phase, .authorized)
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

    func testRejectedVideoDoesNotBlockLaterVideo() async throws {
        let api = StubAPI(), vault = MemoryVault()
        try seed(api, vault)
        let directory = queueDirectory(), queue = CaptureQueue(directory: directory)
        let session = try account(api, vault, queue: queue)
        await session.bootstrap()
        for name in ["invalid.mov", "valid.mov"] {
            let file = directory.appendingPathComponent(name)
            try Data("video".utf8).write(to: file)
            session.queueCapture(file, owner: session.captureOwner)
        }
        api.uploadError = ClientError.unsupportedMedia
        await session.uploadPending()
        XCTAssertNotNil(queue.captures[0].uploadBlocked)
        XCTAssertNil(queue.captures[1].uploadBlocked)
        api.uploadError = nil
        await session.uploadPending()
        XCTAssertNil(queue.captures[0].receipt)
        XCTAssertNotNil(queue.captures[1].receipt)
        XCTAssertEqual(session.unsyncedVideoCount, 1)
        XCTAssertEqual(session.syncProgress, 0.5)
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

    func testEndSessionRevokesBeforeDeletingOnlyOwnedFilesAndCredentials() async throws {
        let api = StubAPI(), vault = MemoryVault()
        try seed(api, vault)
        let directory = queueDirectory(), queue = CaptureQueue(directory: directory)
        let owned = directory.appendingPathComponent("owned.mov")
        let other = directory.appendingPathComponent("other.mov")
        try Data("owned".utf8).write(to: owned)
        try Data("other".utf8).write(to: other)
        try queue.enqueue(file: owned, origin: origin, installationID: api.id)
        try queue.enqueue(file: other, origin: origin, installationID: UUID())
        let session = try account(api, vault, queue: queue)
        await session.bootstrap()
        XCTAssertTrue(session.endSessionWarning.contains("permanently deletes"))
        let ended = await session.endSession()
        XCTAssertTrue(ended)
        XCTAssertEqual(api.endCalls, 1)
        XCTAssertFalse(FileManager.default.fileExists(atPath: owned.path))
        XCTAssertTrue(FileManager.default.fileExists(atPath: other.path))
        XCTAssertEqual(queue.captures.count, 1)
        XCTAssertNil(vault.values[origin])
        XCTAssertEqual(session.phase, .home)
    }

    func testFailedEndRetainsDataAndRestartRetriesWithoutAutoLogin() async throws {
        let api = StubAPI(), vault = MemoryVault()
        try seed(api, vault)
        let directory = queueDirectory(), queue = CaptureQueue(directory: directory)
        let file = directory.appendingPathComponent("pickup.mov")
        try Data("video".utf8).write(to: file)
        try queue.enqueue(file: file, origin: origin, installationID: api.id)
        let session = try account(api, vault, queue: queue)
        await session.bootstrap()
        api.endError = URLError(.networkConnectionLost)
        let failed = await session.endSession()
        XCTAssertFalse(failed)
        XCTAssertTrue(FileManager.default.fileExists(atPath: file.path))
        XCTAssertEqual(vault.values[origin]?.endingSession, true)
        XCTAssertTrue(session.endCleanupPending)
        let previousMeCalls = api.meCalls
        api.endError = nil
        let restarted = try account(api, vault, queue: CaptureQueue(directory: directory))
        await restarted.bootstrap()
        XCTAssertEqual(api.meCalls, previousMeCalls)
        XCTAssertEqual(api.endCalls, 2)
        XCTAssertEqual(restarted.phase, .home)
        XCTAssertFalse(FileManager.default.fileExists(atPath: file.path))
    }

    func testMismatchedEndAcknowledgementCannotDeleteVideos() async throws {
        let api = StubAPI(), vault = MemoryVault()
        try seed(api, vault)
        api.endID = UUID()
        let directory = queueDirectory(), queue = CaptureQueue(directory: directory)
        let file = directory.appendingPathComponent("pickup.mov")
        try Data("video".utf8).write(to: file)
        try queue.enqueue(file: file, origin: origin, installationID: api.id)
        let session = try account(api, vault, queue: queue)
        await session.bootstrap()
        let ended = await session.endSession()
        XCTAssertFalse(ended)
        XCTAssertTrue(FileManager.default.fileExists(atPath: file.path))
        XCTAssertNotNil(vault.values[origin])
    }

    func testCommittedReceiptLookupAvoidsRetransmittingLostResponse() async throws {
        let api = StubAPI(), vault = MemoryVault()
        try seed(api, vault)
        let directory = queueDirectory(), queue = CaptureQueue(directory: directory)
        let file = directory.appendingPathComponent("pickup.mov")
        try Data("video".utf8).write(to: file)
        try queue.enqueue(file: file, origin: origin, installationID: api.id)
        let capture = queue.captures[0]
        api.acceptedUploads[capture.id] = MediaReceipt(id: UUID(), status: "queued", filename: "pickup.mov", sizeBytes: 5, clientCaptureID: capture.id)
        let session = try account(api, vault, queue: queue)
        await session.bootstrap()
        await session.uploadPending()
        XCTAssertEqual(api.uploadCalls, 0)
        XCTAssertNotNil(queue.captures[0].receipt)
        XCTAssertTrue(session.pendingCaptures.isEmpty)
    }

    func testAutomaticUploadsStartAfterQueueingWithoutManualTap() async throws {
        let api = StubAPI(), vault = MemoryVault()
        try seed(api, vault)
        let directory = queueDirectory(), queue = CaptureQueue(directory: directory)
        let session = AccountSession(configuration: try configuration(), vault: vault, queue: queue,
                                     automaticUploads: true, apiFactory: { _ in api })
        await session.bootstrap()
        let file = directory.appendingPathComponent("auto.mov")
        try Data("video".utf8).write(to: file)
        session.queueCapture(file, owner: session.captureOwner)
        for _ in 0..<100 {
            if queue.captures.first?.receipt != nil { break }
            try await Task.sleep(for: .milliseconds(10))
        }
        XCTAssertEqual(api.uploadCalls, 1)
        XCTAssertNotNil(queue.captures.first?.receipt)
        XCTAssertTrue(FileManager.default.fileExists(atPath: file.path))
    }

    func testForegroundConnectionLossDoesNotInterruptValidatedCaptureSession() async throws {
        let api = StubAPI(), vault = MemoryVault()
        try seed(api, vault)
        let session = try account(api, vault)
        await session.bootstrap()
        api.meErrors = [URLError(.notConnectedToInternet)]
        await session.continueLogin()
        XCTAssertEqual(session.phase, .authorized)
        XCTAssertNotNil(session.captureOwner)
    }
}
