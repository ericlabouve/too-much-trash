import Combine
import Foundation
import Network

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
    @Published private(set) var hasSavedCredential = false
    @Published private(set) var uploadingID: UUID?
    @Published private(set) var uploadFraction: Double = 0
    @Published private(set) var uploadBytesPerSecond: Double?
    @Published private(set) var isEndingSession = false
    @Published private(set) var isUploading = false
    private(set) var adminNetworkConfiguration: APIConfiguration?
    @Published private(set) var uploadMessage = "Videos stay on this iPhone until you upload them."
    let queue: CaptureQueue
    private let vault: CredentialVault
    private let apiFactory: @MainActor (APIConfiguration) -> CollectorAPI
    private var api: CollectorAPI?
    private var credential: InstallationCredential?
    private var probeGeneration = UUID()
    private var foreground = true
    private let automaticallyUseLocalCollector: Bool
    private let automaticUploads: Bool
    private var uploadTask: Task<Void, Never>?
    private var retryUploadAt: Date?
    private var retryDelay: TimeInterval = 2
    private var transferStarted: Date?
    private var lastProgressAt: Date?
    private var monitor: NWPathMonitor?
    private var recoveryObserver: UUID?

    init(configuration: APIConfiguration? = APIConfiguration.saved(),
         vault: CredentialVault? = nil, queue: CaptureQueue? = nil,
         automaticallyUseLocalCollector: Bool = false,
         automaticUploads: Bool = false,
         adminNetworkConfiguration: APIConfiguration? = nil,
         apiFactory: @escaping @MainActor (APIConfiguration) -> CollectorAPI = { LiveCollectorAPI(configuration: $0) }) {
        self.automaticallyUseLocalCollector = automaticallyUseLocalCollector
        self.automaticUploads = automaticUploads
        self.adminNetworkConfiguration = adminNetworkConfiguration ??
            (configuration?.simulatorLocal == false ? configuration : nil) ??
            (automaticallyUseLocalCollector ? APIConfiguration.savedAdminNetwork() : nil)
        if automaticallyUseLocalCollector { self.adminNetworkConfiguration?.rememberAdminNetwork() }
        self.configuration = configuration ?? (automaticallyUseLocalCollector ? APIConfiguration.localCollector : nil)
        self.vault = vault ?? KeychainCredentialVault()
        self.queue = queue ?? CaptureQueue()
        self.apiFactory = apiFactory
        api = self.configuration.map(apiFactory)
        if self.configuration == nil { message = "Collector server is not configured. Contact your administrator." }
        if automaticUploads {
            recoveryObserver = BackgroundUploads.shared.setRecoveredHandler { [weak self] request, data, response in
                self?.recoverUpload(request: request, data: data, response: response)
            }
            let watcher = NWPathMonitor()
            watcher.pathUpdateHandler = { [weak self] path in
                guard path.status == .satisfied else { return }
                Task { @MainActor in self?.kickUploads() }
            }
            watcher.start(queue: DispatchQueue(label: "org.toomuchtrash.connectivity"))
            monitor = watcher
        }
    }

    deinit {
        monitor?.cancel(); uploadTask?.cancel()
        if let recoveryObserver { BackgroundUploads.shared.removeRecoveredHandler(recoveryObserver) }
    }

    func configure(_ value: APIConfiguration) async {
        guard !busy, !isUploading, !isEndingSession else { return }
        configuration = value
        if !value.simulatorLocal, value.privateAdminOrigin != nil { adminNetworkConfiguration = value }
        value.save()
        api = apiFactory(value)
        credential = nil
        hasSavedCredential = false
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
            hasSavedCredential = credential != nil
            if credential?.endingSession == true { _ = await endSession(); return }
            if credential != nil { await continueLogin() }
        } catch { hasSavedCredential = true; handle(error) }
        await probeAdmin()
    }

    func continueLogin() async {
        guard !busy, !isUploading, !isEndingSession, retryAllowed() else { return }
        guard let configuration, api != nil else { handle(ClientError.configuration); return }
        let wasAuthorized = phase == .authorized && installation != nil
        busy = true
        phase = .validating
        defer { busy = false }
        do {
            credential = try vault.load(origin: configuration.publicOrigin)
            hasSavedCredential = credential != nil
            guard credential != nil else { throw ClientError.noCredential }
            try await validateInstallation()
            phase = .authorized
            message = "Access confirmed."
            kickUploads()
        } catch {
            if wasAuthorized && ((error as? ClientError) == .network || (error as? ClientError) == .server || error is URLError) {
                phase = .authorized
                uploadMessage = "Waiting for connection. Videos are saved locally."
            } else { handle(error) }
        }
    }

    func register(invite: String, name: String) async -> Bool {
        guard !busy, retryAllowed() else { return false }
        guard credential?.endingSession != true else { message = "Finish ending the previous session first."; return false }
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
            hasSavedCredential = true
            try await validateInstallation()
            phase = .authorized
            message = "Registration complete."
            kickUploads()
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
            kickUploads()
        } catch { uploadMessage = "Video saved locally, but its upload could not be queued. Please keep the app installed." }
    }

    var currentCaptures: [QueuedCapture] {
        guard let configuration, let credential else { return [] }
        return queue.matching(origin: configuration.publicOrigin, installationID: credential.installationID)
    }

    func uploadPending() async {
        guard !busy, !isUploading, !isEndingSession, retryAllowed(), phase == .authorized, let api else { return }
        guard !queue.storageUnavailable else { uploadMessage = "Private video storage needs attention. Videos are retained."; return }
        isUploading = true
        defer { isUploading = false; uploadingID = nil }
        do {
            try await validateInstallation()
            // Older servers do not guarantee idempotency; never blindly retry there.
            guard installation?.mediaContractVersion == 1 else {
                uploadMessage = "Automatic sync requires the updated backend. Videos are saved locally."
                return
            }
            while let capture = currentCaptures.first(where: { $0.receipt == nil && $0.uploadBlocked == nil }) {
                try Task.checkCancellation()
                guard !isEndingSession else { return }
                uploadingID = capture.id
                uploadFraction = 0
                transferStarted = Date()
                uploadBytesPerSecond = nil
                let receipt: MediaReceipt
                do {
                    receipt = try await authorized { try await api.uploaded(captureID: capture.id, token: $0) }
                } catch ClientError.missingMedia {
                    receipt = try await authorized { token in
                        try await api.upload(file: queue.file(for: capture), captureID: capture.id, token: token) { [weak self] sent, expected in
                            guard let self, self.uploadingID == capture.id, expected > 0 else { return }
                            self.uploadFraction = min(1, Double(sent) / Double(expected))
                            self.lastProgressAt = Date()
                            if let start = self.transferStarted, Date().timeIntervalSince(start) >= 1, sent > 0 {
                                self.uploadBytesPerSecond = Double(sent) / Date().timeIntervalSince(start)
                            }
                        }
                    }
                }
                let size = (try FileManager.default.attributesOfItem(atPath: queue.file(for: capture).path)[.size] as? NSNumber)?.int64Value
                guard receipt.clientCaptureID == capture.id, receipt.sizeBytes == size else { throw ClientError.invalidResponse }
                try queue.record(receipt, for: capture.id)
                uploadingID = nil
                uploadFraction = 0
                retryDelay = 2
                retryUploadAt = nil
            }
            uploadMessage = unsyncedVideoCount == 0 ? "All videos synced." : "Some videos need attention and have not synced."
        } catch {
            let failedCaptureID = uploadingID
            uploadingID = nil
            uploadFraction = 0
            uploadBytesPerSecond = nil
            if error is CancellationError || (error as? URLError)?.code == .cancelled { return }
            let failure = error as? ClientError ?? .network
            uploadMessage = failure.message
            switch failure {
            case .unauthorized:
                handle(failure)
            case .rateLimited(let seconds): retryUploadAt = Date().addingTimeInterval(seconds)
            case .uploadTooLarge, .unsupportedMedia, .uploadEmpty, .idempotencyConflict:
                if let failedCaptureID {
                    do { try queue.blockUpload(failure.message, for: failedCaptureID); retryUploadAt = nil }
                    catch { retryUploadAt = .distantFuture }
                }
            case .quotaExceeded: retryUploadAt = Date().addingTimeInterval(60)
            case .storage:
                retryUploadAt = .distantFuture
            default:
                retryUploadAt = Date().addingTimeInterval(retryDelay)
                retryDelay = min(60, retryDelay * 2)
            }
        }
    }

    var pendingCaptures: [QueuedCapture] { currentCaptures.filter { $0.receipt == nil } }
    var unsyncedVideoCount: Int {
        guard let configuration, let credential else { return pendingCaptures.count }
        return pendingCaptures.count + queue.untrackedVideoCount(origin: configuration.publicOrigin, installationID: credential.installationID)
    }
    var syncProgress: Double {
        let count = currentCaptures.count
        return count == 0 ? 1 : min(1, (Double(count - pendingCaptures.count) + (uploadingID == nil ? 0 : uploadFraction)) / Double(count))
    }
    var estimatedUploadTime: String {
        guard !pendingCaptures.contains(where: { $0.uploadBlocked != nil }) else { return "Some videos need attention. Time remaining unknown." }
        guard uploadingID != nil, let speed = uploadBytesPerSecond, speed > 0,
              let lastProgressAt, Date().timeIntervalSince(lastProgressAt) < 10 else { return "Time remaining unknown—waiting for connection." }
        let bytes = pendingCaptures.reduce(Double(0)) { sum, capture in
            sum + Double(capture.sizeBytes ?? 0) * (capture.id == uploadingID ? 1 - uploadFraction : 1)
        }
        guard bytes > 0 else { return "Time remaining unknown." }
        let seconds = max(1, Int(ceil(bytes / speed)))
        return seconds < 60 ? "About \(seconds) seconds remaining." : "About \(Int(ceil(Double(seconds) / 60))) minutes remaining."
    }
    var endSessionWarning: String {
        if queue.storageUnavailable { return "Private storage is unavailable. Do not end the session until it can be checked." }
        if unsyncedVideoCount == 0 { return "All videos synced. This deactivates this installation and deletes local session videos. You’ll need a new invite." }
        return "\(unsyncedVideoCount) videos haven’t uploaded. \(estimatedUploadTime) Stay on the dashboard to finish. Ending now permanently deletes these videos from this device and deactivates this installation."
    }

    func syncTick() { kickUploads() }
    var endCleanupPending: Bool { credential?.endingSession == true }

    private func kickUploads() {
        guard automaticUploads, foreground, phase == .authorized, !isEndingSession, !busy,
              !pendingCaptures.isEmpty, uploadTask == nil,
              pendingCaptures.contains(where: { $0.uploadBlocked == nil }),
              retryUploadAt == nil || retryUploadAt! <= Date() else { return }
        uploadTask = Task { [weak self] in
            guard let self else { return }
            await self.uploadPending()
            self.uploadTask = nil
        }
    }

    private func recoverUpload(request: URLRequest, data: Data, response: HTTPURLResponse) {
        guard response.statusCode == 202,
              response.value(forHTTPHeaderField: "Content-Type")?.hasPrefix("application/json") == true,
              let key = request.value(forHTTPHeaderField: "Idempotency-Key"), let id = UUID(uuidString: key),
              let capture = queue.captures.first(where: { $0.id == id }),
              request.url == URL(string: capture.origin)?.appendingPathComponent("api/v1/media"),
              let receipt = try? JSONDecoder().decode(MediaReceipt.self, from: data), receipt.clientCaptureID == id,
              let size = try? FileManager.default.attributesOfItem(atPath: queue.file(for: capture).path)[.size] as? NSNumber,
              size.int64Value == receipt.sizeBytes else { return }
        do { try queue.record(receipt, for: id) }
        catch { uploadMessage = "Upload confirmed, but local sync metadata needs attention. Videos retained." }
    }

    func endSession() async -> Bool {
        guard !busy, !isEndingSession, let configuration, let api, var current = credential else { return false }
        guard !queue.storageUnavailable else { message = "Private storage needs attention. Session was not ended."; return false }
        guard installation?.mediaContractVersion == 1 || current.endingSession == true else {
            message = "End Session requires the updated backend."; return false
        }
        isEndingSession = true
        busy = true
        defer { busy = false; isEndingSession = false }
        do {
            current.endingSession = true
            try vault.save(current, origin: configuration.publicOrigin)
            credential = current
            uploadTask?.cancel()
            await BackgroundUploads.shared.cancel(captureIDs: Set(currentCaptures.map(\.id)), origin: configuration.publicOrigin)
            await uploadTask?.value
            uploadTask = nil
            if current.revocationConfirmed != true {
                let result = try await api.endSession(refreshToken: current.refreshToken)
                guard result.revoked, result.installationID == current.installationID else { throw ClientError.invalidResponse }
                current.revocationConfirmed = true
                try vault.save(current, origin: configuration.publicOrigin)
                credential = current
            }
            try BackgroundUploads.shared.removeStaged(captureIDs: Set(currentCaptures.map(\.id)))
            try queue.removeSession(origin: configuration.publicOrigin, installationID: current.installationID)
            try vault.remove(origin: configuration.publicOrigin)
            credential = nil
            hasSavedCredential = false
            installation = nil
            uploadingID = nil
            retryUploadAt = nil
            phase = .home
            message = "Session ended. Register with a new invite."
            return true
        } catch {
            message = "Session cleanup has not finished. Your remaining local videos and credentials are retained. Retry End Session."
            phase = .retry
            return false
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
    func resume() { foreground = true; kickUploads() }

    func probeAdmin() async {
        probeGeneration = UUID()
        let generation = probeGeneration
        guard foreground else { return }
        let network = adminNetworkConfiguration
        let reachable: Bool
        if let network, !network.simulatorLocal, network.privateAdminOrigin?.scheme == "https" {
            reachable = await apiFactory(network).adminReachable()
        } else { reachable = false }
        guard foreground, !Task.isCancelled, probeGeneration == generation else { return }
        adminVisible = reachable
        if !reachable, automaticallyUseLocalCollector, phase != .authorized { await useLocalCollector() }
    }

    func useLocalCollector() async {
        hideAdmin()
        guard !busy, !isUploading, !isEndingSession, !endCleanupPending,
              let local = APIConfiguration.localCollector, configuration != local else { return }
        // Never switch origins while an enrollment/upload is in flight.
        await configure(local)
    }

    func verifiedAdminURL() async -> URL? {
        await probeAdmin()
        guard adminVisible else { return nil }
        if configuration?.simulatorLocal == true {
            guard let api, let origin = configuration?.privateAdminOrigin else { return nil }
            let reachable = await api.adminReachable()
            return foreground && adminVisible && reachable ? origin : nil
        }
        return adminNetworkConfiguration?.privateAdminOrigin
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
