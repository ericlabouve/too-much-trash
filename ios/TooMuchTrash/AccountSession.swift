import Combine
import Foundation

@MainActor
final class AccountSession: ObservableObject {
    enum Phase: Equatable { case home, validating, authorized, retry, needsInvite }
    @Published private(set) var phase: Phase = .home
    @Published private(set) var message = "Register with an invite to begin collecting."
    @Published private(set) var installation: Installation?
    @Published private(set) var adminVisible = false
    @Published private(set) var busy = false
    @Published private(set) var retryNotBefore: Date?
    @Published private(set) var configuration: APIConfiguration?
    @Published private(set) var uploadMessage = "Videos stay on this iPhone until you upload them."
    let queue: CaptureQueue
    private let vault: CredentialVault
    private let apiFactory: @MainActor (APIConfiguration) -> CollectorAPI
    private var api: CollectorAPI?
    private var credential: InstallationCredential?
    private var probeGeneration = UUID()
    private var foreground = true

    init(configuration: APIConfiguration? = APIConfiguration.saved(),
         vault: CredentialVault? = nil, queue: CaptureQueue? = nil,
         apiFactory: @escaping @MainActor (APIConfiguration) -> CollectorAPI = { LiveCollectorAPI(configuration: $0) }) {
        self.configuration = configuration
        self.vault = vault ?? KeychainCredentialVault()
        self.queue = queue ?? CaptureQueue()
        self.apiFactory = apiFactory
        api = configuration.map(apiFactory)
        if configuration == nil { message = "Set the collector server address to get started." }
    }

    func configure(_ value: APIConfiguration) async {
        guard !busy else { return }
        configuration = value
        value.save()
        api = apiFactory(value)
        credential = nil
        installation = nil
        phase = .home
        message = "Register with an invite to begin collecting."
        await bootstrap()
    }

    func bootstrap() async {
        guard !busy else { return }
        hideAdmin()
        guard let configuration else { return }
        do {
            credential = try vault.load(origin: configuration.publicOrigin)
            if credential != nil { await continueLogin() }
        } catch { handle(error) }
        await probeAdmin()
    }

    func continueLogin() async {
        guard !busy, retryAllowed() else { return }
        guard let configuration, api != nil else { handle(ClientError.configuration); return }
        busy = true
        phase = .validating
        defer { busy = false }
        do {
            credential = try vault.load(origin: configuration.publicOrigin)
            guard credential != nil else { throw ClientError.noCredential }
            try await validateInstallation()
            phase = .authorized
            message = "Access confirmed."
        } catch { handle(error) }
    }

    func register(invite: String, name: String) async -> Bool {
        guard !busy, retryAllowed() else { return false }
        guard let configuration, let api else { handle(ClientError.configuration); return false }
        let code = invite.trimmingCharacters(in: .whitespacesAndNewlines)
        let label = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !code.isEmpty, code.count <= 256, label.count <= 80 else {
            message = "Enter an invite up to 256 characters and a name up to 80 characters."
            return false
        }
        busy = true
        phase = .validating
        defer { busy = false }
        var enrolled = false
        var stored = false
        do {
            let response = try await api.enroll(invite: code, name: label.isEmpty ? nil : label)
            enrolled = true
            let next = try InstallationCredential(enrollment: response)
            // Preserve any previous Keychain item until the atomic update succeeds.
            try vault.save(next, origin: configuration.publicOrigin)
            stored = true
            credential = next
            try await validateInstallation()
            phase = .authorized
            message = "Registration complete."
            return true
        } catch {
            handle(error)
            let failure = error as? ClientError
            if !enrolled {
                switch failure {
                case .invitationInvalid?, .rateLimited?, .validation?: break
                default: message += " The invite may have been consumed. If retry is rejected, ask your administrator for help."
                }
            } else if !stored {
                message += " Registration may have consumed the invite. Ask your administrator for help."
            }
            return false
        }
    }

    private func validateInstallation() async throws {
        guard let api else { throw ClientError.configuration }
        let confirmed = try await authorized { try await api.me(token: $0) }
        guard confirmed.installationID == credential?.installationID else { throw ClientError.invalidResponse }
        installation = confirmed
    }

    private func refreshCredential() async throws {
        guard let api, let configuration, var current = credential else { throw ClientError.noCredential }
        // The backend, rather than the phone's clock, decides refresh validity.
        let response = try await api.refresh(token: current.refreshToken)
        guard response.tokenType == "Bearer", !response.accessToken.isEmpty, response.expiresIn > 0 else {
            throw ClientError.invalidResponse
        }
        current.accessToken = response.accessToken
        current.accessExpiresAt = Date().addingTimeInterval(TimeInterval(response.expiresIn))
        try vault.save(current, origin: configuration.publicOrigin)
        credential = current
    }

    private func authorized<T>(_ operation: (String) async throws -> T) async throws -> T {
        guard let current = credential else { throw ClientError.noCredential }
        let refreshed = current.accessExpiresAt <= Date().addingTimeInterval(15)
        if refreshed { try await refreshCredential() }
        do {
            return try await operation(credential!.accessToken)
        } catch ClientError.unauthorized("access_invalid") {
            // One refresh retry only; revoked credentials never enter this path.
            guard !refreshed else { throw ClientError.unauthorized("access_invalid") }
            try await refreshCredential()
            return try await operation(credential!.accessToken)
        }
    }

    struct CaptureOwner {
        let origin: URL
        let installationID: UUID
    }

    var captureOwner: CaptureOwner? {
        guard let configuration, let credential, installation?.installationID == credential.installationID else { return nil }
        return CaptureOwner(origin: configuration.publicOrigin, installationID: credential.installationID)
    }

    func queueCapture(_ file: URL, owner: CaptureOwner?) {
        guard let owner else {
            uploadMessage = "Video saved locally. No installation identity is available for upload."
            return
        }
        do {
            try queue.enqueue(file: file, origin: owner.origin, installationID: owner.installationID)
            uploadMessage = "Video saved and queued on this iPhone."
        } catch { uploadMessage = "Video saved locally, but its upload could not be queued. Please keep the app installed." }
    }

    var currentCaptures: [QueuedCapture] {
        guard let configuration, let credential else { return [] }
        return queue.matching(origin: configuration.publicOrigin, installationID: credential.installationID)
    }

    func uploadPending() async {
        guard !busy, retryAllowed(), phase == .authorized, let api else { return }
        busy = true
        defer { busy = false }
        do {
            try await validateInstallation()
            for capture in currentCaptures where capture.receipt == nil {
                let receipt = try await authorized { try await api.upload(file: queue.file(for: capture), token: $0) }
                try queue.record(receipt, for: capture.id)
            }
            uploadMessage = "Uploads accepted. Local videos are retained."
        } catch {
            uploadMessage = "Upload stopped. Your videos remain queued on this iPhone."
            handle(error)
            uploadMessage += " " + message
            if !(error is ClientError) || (error as? ClientError) == .invalidResponse || (error as? ClientError) == .storage {
                uploadMessage += " If the server already accepted a video, retry may create a duplicate."
            }
        }
    }

    func refreshUploadStatus() async {
        guard !busy, retryAllowed(), phase == .authorized, let api else { return }
        busy = true
        defer { busy = false }
        do {
            for capture in currentCaptures {
                guard let previous = capture.receipt else { continue }
                let receipt = try await authorized { try await api.media(id: previous.id, token: $0) }
                guard receipt.id == previous.id else { throw ClientError.invalidResponse }
                try queue.record(receipt, for: capture.id)
            }
            uploadMessage = "Processing status updated."
        } catch { handle(error); uploadMessage = message + " Local videos are retained." }
    }

    func returnHome() { phase = .home }

    func hideAdmin() {
        probeGeneration = UUID()
        adminVisible = false
    }

    func suspend() { foreground = false; hideAdmin() }
    func resume() { foreground = true }

    func probeAdmin() async {
        hideAdmin()
        let generation = probeGeneration
        guard foreground, let api, configuration?.privateAdminOrigin != nil else { return }
        let reachable = await api.adminReachable()
        guard foreground, !Task.isCancelled, probeGeneration == generation else { return }
        adminVisible = reachable
    }

    func verifiedAdminURL() async -> URL? {
        await probeAdmin()
        return adminVisible ? configuration?.privateAdminOrigin : nil
    }

    private func handle(_ error: Error) {
        let failure = error as? ClientError ?? .network
        if case .rateLimited(let seconds) = failure { retryNotBefore = Date().addingTimeInterval(seconds) }
        message = failure.message
        switch failure {
        case .noCredential, .invitationInvalid: phase = .home
        case .unauthorized(let code) where ["access_invalid", "access_revoked", "refresh_invalid"].contains(code):
            phase = .needsInvite
            installation = nil
        case .rateLimited, .quotaExceeded, .uploadTooLarge, .missingMedia:
            if phase != .authorized { phase = .retry }
        default: phase = .retry
        }
        // A failure never deletes Keychain items or capture files.
    }

    private func retryAllowed() -> Bool {
        guard let deadline = retryNotBefore else { return true }
        if deadline <= Date() { retryNotBefore = nil; return true }
        message = "Please wait before retrying. Your credentials and videos are retained."
        return false
    }
}
