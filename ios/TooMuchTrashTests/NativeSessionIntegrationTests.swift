import Foundation
import XCTest
@testable import TooMuchTrash

/// Opt-in local integration. Fixtures contain secrets and are never committed or logged.
@MainActor
final class NativeSessionIntegrationTests: XCTestCase {
    private struct Fixture: Decodable { let invite_code: String; let collector_origin: String }

    func testLocalAutomaticRetryAndEndCleanup() async throws {
        #if DEBUG && targetEnvironment(simulator)
        let fixtures = FileManager.default.temporaryDirectory.appendingPathComponent("native-session-fixture")
        let input = fixtures.appendingPathComponent("invite.json")
        guard FileManager.default.fileExists(atPath: input.path) else {
            throw XCTSkip("Requires an explicitly approved private local integration fixture.")
        }
        let fixture = try JSONDecoder().decode(Fixture.self, from: Data(contentsOf: input))
        let configuration = try APIConfiguration(publicURL: fixture.collector_origin, simulatorLocal: true)
        let vault = KeychainCredentialVault(service: "org.toomuchtrash.integration." + UUID().uuidString)
        let storage = fixtures.appendingPathComponent("private-captures")
        let queue = CaptureQueue(directory: storage)
        let transport = LostAcknowledgementTransport()
        let api = LiveCollectorAPI(configuration: configuration, transport: transport)
        let account = AccountSession(configuration: configuration, vault: vault, queue: queue,
                                     automaticUploads: true, apiFactory: { _ in api })
        let registered = await account.register(invite: fixture.invite_code, name: "Native session sync integration")
        XCTAssertTrue(registered, "Native registration must succeed; secrets omitted.")
        guard registered, let credential = try vault.load(origin: configuration.publicOrigin) else { return }
        let folder = try queue.recordingDirectory(origin: configuration.publicOrigin, installationID: credential.installationID)
        let original = folder.appendingPathComponent("integration.mov")
        try FileManager.default.copyItem(at: fixtures.appendingPathComponent("sample.mov"), to: original)
        account.queueCapture(original, owner: account.captureOwner)
        let deadline = Date().addingTimeInterval(45)
        while queue.captures.first?.receipt == nil && Date() < deadline {
            account.syncTick()
            try await Task.sleep(for: .milliseconds(250))
        }
        let capture = try XCTUnwrap(queue.captures.first)
        let receipt = try XCTUnwrap(capture.receipt, "Automatic retry must recover the committed receipt.")
        XCTAssertTrue(transport.droppedAcknowledgement)
        XCTAssertEqual(transport.uploadCalls, 1, "Retry must lookup receipt rather than resend accepted bytes.")
        XCTAssertEqual(account.unsyncedVideoCount, 0)
        let repeated = try await api.upload(file: original, captureID: capture.id, token: credential.accessToken, progress: { _, _ in })
        XCTAssertEqual(repeated.id, receipt.id)
        let found = try await api.uploaded(captureID: capture.id, token: credential.accessToken)
        XCTAssertEqual(found.id, receipt.id)
        // A partial/untracked recording must be warned about and cleaned up too.
        let unfinished = folder.appendingPathComponent("unfinished.mov")
        try Data([0, 1, 2]).write(to: unfinished)
        XCTAssertEqual(account.unsyncedVideoCount, 1)
        XCTAssertTrue(account.endSessionWarning.contains("permanently deletes"))
        let ended = await account.endSession()
        XCTAssertTrue(ended)
        XCTAssertEqual(account.phase, .home)
        XCTAssertNil(try vault.load(origin: configuration.publicOrigin))
        XCTAssertFalse(FileManager.default.fileExists(atPath: original.path))
        XCTAssertFalse(FileManager.default.fileExists(atPath: unfinished.path))
        XCTAssertTrue(queue.captures.isEmpty)
        // Non-secret identifiers let the backend verify quota/revocation/blob retention.
        let result = ["installation_id": credential.installationID.uuidString,
                      "media_id": receipt.id.uuidString, "capture_id": capture.id.uuidString]
        try JSONEncoder().encode(result).write(to: fixtures.appendingPathComponent("result.json"), options: .atomic)
        #else
        throw XCTSkip("Local integration is Debug Simulator only.")
        #endif
    }
}

@MainActor
private final class LostAcknowledgementTransport: HTTPTransport {
    private let live = SecureHTTPTransport()
    private(set) var droppedAcknowledgement = false
    private(set) var uploadCalls = 0
    func data(for request: URLRequest) async throws -> (Data, HTTPURLResponse) { try await live.data(for: request) }
    func upload(for request: URLRequest, from file: URL) async throws -> (Data, HTTPURLResponse) {
        try await upload(for: request, from: file, progress: { _, _ in })
    }
    func upload(for request: URLRequest, from file: URL,
                progress: @escaping @MainActor @Sendable (Int64, Int64) -> Void) async throws -> (Data, HTTPURLResponse) {
        uploadCalls += 1
        let response = try await live.upload(for: request, from: file, progress: progress)
        if !droppedAcknowledgement && response.1.statusCode == 202 {
            droppedAcknowledgement = true
            throw URLError(.networkConnectionLost)
        }
        return response
    }
}
