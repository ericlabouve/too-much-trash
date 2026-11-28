import Combine
import Foundation
import Network
import UIKit

@MainActor
final class AccountSession: ObservableObject {
    enum Phase: Equatable { case home, validating, authorized, retry, needsInvite }
    @Published private(set) var phase: Phase = .home
    @Published private(set) var message = "Register with an invite to begin collecting."
    @Published private(set) var installation: Installation?
    @Published private(set) var adminVisible = false
    @Published private(set) var availableServers: [AvailableServer] = []
    @Published private(set) var refreshingServers = false
    @Published private(set) var serverDiscoveryMessage = ""
    @Published private(set) var busy = false
    @Published private(set) var retryNotBefore: Date?
    @Published private(set) var configuration: APIConfiguration?
    @Published private(set) var hasSavedCredential = false
    @Published private(set) var uploadProgress: [UUID: Double] = [:]
    @Published private(set) var uploadBytesPerSecond: Double?
    @Published private(set) var isEndingSession = false
    @Published private(set) var endingSessionStage = "Signing out…" {
        didSet {
            #if DEBUG
            UserDefaults.standard.set(endingSessionStage, forKey: "signoutLastStage")
            #endif
        }
    }
    var endOperationTimeout: TimeInterval = 10
    @Published private(set) var isUploading = false
    @Published private(set) var isDeletingCapture = false
    @Published private(set) var watchServerReachable: Bool?
    private(set) var adminNetworkConfiguration: APIConfiguration?
    @Published private(set) var uploadMessage = "Local videos expire 24 hours after upload or 72 hours after recording if unsynced."
    let cameraSettings = CameraViewSettings()
    let cleanup = CleanupSessionStore()
    let queue: CaptureQueue
    private let vault: CredentialVault
    private let apiFactory: @MainActor (APIConfiguration) -> CollectorAPI
    private var api: CollectorAPI?
    private var credential: InstallationCredential?
    private var credentialRefresh: Task<Void, Error>?
    private var probeGeneration = UUID()
    private var foreground = true
    private var hasBootstrapped = false
    private let automaticallyUseLocalCollector: Bool
    private let automaticUploads: Bool
    private let discoverAdminServers: Bool
    private var verifiedAdminConfiguration: APIConfiguration?
    private var catalogServers: [AvailableServer] = []
    private var lastCatalogCheck: Date?
    @Published private(set) var fullRecordingUploadMessage = ""
    @Published private(set) var fullRecordings: [FullSessionRecording] = []
    private var preparedFullOwners = Set<URL>()
    private var cleanupSyncing = false
    private var lastCleanupSync = Date.distantPast
    private var uploadTask: Task<Void, Never>?
    private var uploadBackgroundTask = UIBackgroundTaskIdentifier.invalid
    private var requestedUploadBackgroundTime = false
    private var retentionTask: Task<Void, Never>?
    private var nextRetentionCheck = Date.distantPast
    private var retryUploadAt: Date?
    private var retryDelay: TimeInterval = 2
    private var transferStarted: Date?
    private var lastProgressAt: Date?
    private var sentByCapture: [UUID: Int64] = [:]
    private var monitor: NWPathMonitor?
    private var recoveryObserver: UUID?

    init(configuration: APIConfiguration? = APIConfiguration.saved(),
         vault: CredentialVault? = nil, queue: CaptureQueue? = nil,
         automaticallyUseLocalCollector: Bool = false,
         automaticUploads: Bool = false,
         discoverAdminServers: Bool = false,
         adminNetworkConfiguration: APIConfiguration? = nil,
         apiFactory: @escaping @MainActor (APIConfiguration) -> CollectorAPI = { LiveCollectorAPI(configuration: $0) }) {
        self.automaticallyUseLocalCollector = automaticallyUseLocalCollector
        self.automaticUploads = automaticUploads
        self.discoverAdminServers = discoverAdminServers
        self.adminNetworkConfiguration = adminNetworkConfiguration ??
            (configuration?.privateAdminOrigin?.scheme == "https" ? configuration : nil) ??
            (automaticallyUseLocalCollector ? APIConfiguration.savedAdminNetwork() : nil)
        if automaticallyUseLocalCollector { self.adminNetworkConfiguration?.rememberAdminNetwork() }
        self.configuration = configuration ?? (automaticallyUseLocalCollector ? APIConfiguration.localCollector : nil)
        self.vault = vault ?? KeychainCredentialVault()
        self.queue = queue ?? CaptureQueue()
        self.apiFactory = apiFactory
        api = self.configuration.map(apiFactory)
        if self.configuration == nil { message = "Collector server is not configured. Contact your administrator." }
        if automaticUploads {
            if !self.queue.storageUnavailable {
                do { try self.queue.removeAbandonedRecordings(now: Date()) }
                catch { uploadMessage = "Could not clear some old local recordings." }
            }
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
        cleanup.onChange = { [weak self] in
            self?.objectWillChange.send()
            Task { await self?.syncCleanup() }
        }
    }

    deinit {
        monitor?.cancel(); uploadTask?.cancel(); retentionTask?.cancel(); credentialRefresh?.cancel()
        if let recoveryObserver { BackgroundUploads.shared.removeRecoveredHandler(recoveryObserver) }
        if uploadBackgroundTask != .invalid {
            let task = uploadBackgroundTask
            Task { @MainActor in UIApplication.shared.endBackgroundTask(task) }
        }
    }

    func configure(_ value: APIConfiguration) async {
        guard !busy, !isUploading, !isEndingSession, !isDeletingCapture, retentionTask == nil else { return }
        cleanup.pauseForAccountChange()
        configuration = value
        if value.privateAdminOrigin?.scheme == "https" { adminNetworkConfiguration = value }
        value.save()
        api = apiFactory(value)
        credential = nil
        hasSavedCredential = false
        installation = nil
        phase = .home
        message = "Register with an invite to begin collecting."
        await bootstrap()
    }

    func bootstrap(probeAdmin: Bool = true) async {
        guard !busy else { return }
        defer {
            hasBootstrapped = true
            kickUploads()
        }
        hideAdmin()
        guard let configuration else { return }
        do {
            credential = try vault.load(origin: configuration.publicOrigin)
            hasSavedCredential = credential != nil
            if credential?.endingSession == true { _ = await endSession(); return }
            if credential != nil { await continueLogin() }
        } catch { hasSavedCredential = true; handle(error) }
        if probeAdmin { await self.probeAdmin() }
    }

    func continueLogin() async {
        guard !busy, !isUploading, !isEndingSession, !isDeletingCapture, retentionTask == nil, retryAllowed() else { return }
        guard let configuration, api != nil else { handle(ClientError.configuration); return }
        let wasAuthorized = phase == .authorized && installation != nil
        busy = true
        phase = .validating
        defer {
            busy = false
            kickUploads()
        }
        do {
            credential = try vault.load(origin: configuration.publicOrigin)
            hasSavedCredential = credential != nil
            guard credential != nil else { throw ClientError.noCredential }
            try await validateInstallation()
            phase = .authorized
            message = "Access confirmed."
        } catch {
            if wasAuthorized && ((error as? ClientError) == .network || (error as? ClientError) == .server || error is URLError) {
                phase = .authorized
                uploadMessage = "Waiting for connection. Videos are saved locally."
            } else { handle(error) }
        }
    }

    func register(invite: String, name: String) async -> Bool {
        guard !busy, retentionTask == nil, retryAllowed() else { return false }
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

    var canAdminProceed: Bool {
        adminVisible && configuration?.publicOrigin == APIConfiguration.developmentNetwork.publicOrigin &&
        configuration?.privateAdminOrigin == APIConfiguration.developmentNetwork.privateAdminOrigin
    }

    func hasDevelopmentKey() throws -> Bool {
        guard let origin = APIConfiguration.developmentNetwork.privateAdminOrigin else { return false }
        return try DevelopmentKeyVault().load(origin: origin) != nil
    }

    func adminProceed(newKey: String? = nil) async -> Bool {
        guard !busy, retentionTask == nil, canAdminProceed, let configuration, let api,
              let privateOrigin = APIConfiguration.developmentNetwork.privateAdminOrigin else { return false }
        guard !hasSavedCredential, credential == nil else {
            message = "An existing installation is saved for this server. Resolve that session before registering another."
            return false
        }
        busy = true
        defer { busy = false }
        do {
            guard await api.adminReachable(), canAdminProceed else { throw ClientError.network }
            let keyVault = DevelopmentKeyVault()
            let key: String
            if let newKey, !newKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                key = newKey.trimmingCharacters(in: .whitespacesAndNewlines)
                try keyVault.save(key, origin: privateOrigin)
            } else {
                guard let saved = try keyVault.load(origin: privateOrigin) else { throw ClientError.noCredential }
                key = saved
            }
            let enrollment = try await api.developmentEnroll(key: key)
            let next = try InstallationCredential(enrollment: enrollment)
            try vault.save(next, origin: configuration.publicOrigin)
            credential = next
            hasSavedCredential = true
            try await validateInstallation()
            phase = .authorized
            message = "Registration complete."
            kickUploads()
            return true
        } catch {
            handle(error)
            message += " If registration completed but the response was lost, check the admin dashboard before retrying."
            return false
        }
    }

    private func validateInstallation() async throws {
        guard let api else { throw ClientError.configuration }
        let confirmed = try await authorized { try await api.me(token: $0) }
        guard confirmed.installationID == credential?.installationID else { throw ClientError.invalidResponse }
        installation = confirmed
        if let owner = captureOwner {
            try cleanup.bind(directory: queue.recordingDirectory(origin: owner.origin, installationID: owner.installationID))
        }
    }

    func refreshWatchQuota() async {
        guard phase == .authorized, !busy, !isEndingSession else { return }
        do { try await validateInstallation(); watchServerReachable = true }
        catch { watchServerReachable = false }
    }

    private func refreshCredential() async throws {
        if let credentialRefresh {
            try await credentialRefresh.value
            try Task.checkCancellation()
            return
        }
        let task = Task { try await performCredentialRefresh() }
        credentialRefresh = task
        defer { credentialRefresh = nil }
        try await task.value
        try Task.checkCancellation()
    }

    private func performCredentialRefresh() async throws {
        guard let api, let configuration, let current = credential else { throw ClientError.noCredential }
        // The backend, rather than the phone's clock, decides refresh validity.
        let response = try await api.refresh(token: current.refreshToken)
        try Task.checkCancellation()
        guard var latest = credential, latest.installationID == current.installationID,
              self.configuration == configuration, latest.endingSession != true else { throw CancellationError() }
        guard response.tokenType == "Bearer", !response.accessToken.isEmpty, response.expiresIn > 0 else {
            throw ClientError.invalidResponse
        }
        latest.accessToken = response.accessToken
        latest.accessExpiresAt = Date().addingTimeInterval(TimeInterval(response.expiresIn))
        try vault.save(latest, origin: configuration.publicOrigin)
        credential = latest
    }

    private func authorized<T>(_ operation: (String) async throws -> T) async throws -> T {
        guard let current = credential else { throw ClientError.noCredential }
        let refreshed = current.accessExpiresAt <= Date().addingTimeInterval(15)
        if refreshed { try await refreshCredential() }
        guard let token = credential?.accessToken else { throw ClientError.noCredential }
        do {
            return try await operation(token)
        } catch ClientError.unauthorized("access_invalid") {
            // One refresh retry only; revoked credentials never enter this path.
            guard !refreshed else { throw ClientError.unauthorized("access_invalid") }
            if credential?.accessToken == token { try await refreshCredential() }
            guard let token = credential?.accessToken else { throw ClientError.noCredential }
            return try await operation(token)
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

    var showDeveloperSensorOverlay: Bool {
        phase == .authorized && installation?.developmentSession == true
    }

    func queueCapture(_ file: URL, owner: CaptureOwner?) {
        guard let owner else {
            uploadMessage = "Video saved locally. No installation identity is available for upload."
            return
        }
        do {
            try queue.enqueue(file: file, origin: owner.origin, installationID: owner.installationID)
            WatchBridge.record(queue.matching(origin: owner.origin, installationID: owner.installationID), owner: owner)
            uploadMessage = "Video saved and queued on this iPhone."
            kickUploads()
        } catch { uploadMessage = "Video saved locally, but its upload could not be queued. Please keep the app installed." }
    }

    func queueEpisode(_ folder: URL, id: UUID, owner: CaptureOwner?) {
        guard let owner else {
            uploadMessage = "Episode saved locally. No installation identity is available for upload."
            return
        }
        do {
            try queue.enqueueEpisode(folder: folder, id: id, origin: owner.origin, installationID: owner.installationID)
            WatchBridge.record(queue.matching(origin: owner.origin, installationID: owner.installationID), owner: owner)
            uploadMessage = "Episode saved and queued on this iPhone."
            kickUploads()
        } catch { uploadMessage = "Episode saved locally, but it could not be queued. Please keep the app installed." }
    }

    var currentCaptures: [QueuedCapture] {
        guard let configuration, let credential else { return [] }
        return queue.matching(origin: configuration.publicOrigin, installationID: credential.installationID)
    }

    func uploadPending() async {
        guard retentionTask == nil else { return }
        _ = await uploadPending(finalAttemptID: nil)
    }

    /// A final attempt allows an expired recording through the ordinary
    /// receipt-first upload path. Return true only when cleanup may proceed.
    private func uploadPending(finalAttemptID: UUID?) async -> Bool {
        guard !busy, !isUploading, !isEndingSession, !isDeletingCapture, retryAllowed(), phase == .authorized, let api else { return false }
        guard !queue.storageUnavailable else { uploadMessage = "Private video storage needs attention. Videos are retained."; return false }
        isUploading = true
        defer {
            isUploading = false
            uploadProgress.removeAll()
            uploadBytesPerSecond = nil
        }
        do {
            try await validateInstallation()
            // Older servers do not guarantee idempotency; never blindly retry there.
            guard installation?.mediaContractVersion == 1 else {
                uploadMessage = "Automatic sync requires the updated backend. Videos are saved locally."
                return false
            }
            // Reattach restored URLSession tasks before starting work on other recordings.
            let restored = automaticUploads ? await BackgroundUploads.shared.activeCaptureIDs() : []
            let resumable = installation?.resumableEpisodeContractVersion == 1
            while true {
                try Task.checkCancellation()
                guard !isEndingSession, mayStartUpload else { return false }
                let eligible = pendingCaptures.filter { capture in
                    guard capture.uploadBlocked == nil else { return false }
                    if let finalAttemptID { return capture.id == finalAttemptID }
                    return !capture.isExpired(at: Date())
                }
                let reattaching = eligible.filter { restored.contains($0.id) }
                let candidates = reattaching + eligible.filter { !restored.contains($0.id) }
                guard let first = candidates.first else { break }
                if queue.episodeFolder(for: first) != nil && installation?.episodeContractVersion != 1 {
                    uploadMessage = "Episode sync requires the updated backend. Recordings remain on this iPhone."
                    return false
                }

                // A lone episode can use all four requests. A pair shares the same
                // budget, with two requests reserved for each episode.
                let canPair = finalAttemptID == nil && resumable && reattaching.count != 1
                    && candidates.prefix(2).allSatisfy { queue.episodeFolder(for: $0) != nil }
                let batch = candidates.prefix(canPair ? 2 : 1)
                let chunkLimit = BackgroundUploads.maximumConcurrentChunks / batch.count
                uploadProgress = Dictionary(uniqueKeysWithValues: batch.map { ($0.id, 0) })
                sentByCapture.removeAll()
                transferStarted = Date()
                lastProgressAt = nil
                uploadBytesPerSecond = nil
                let blocked = try await withThrowingTaskGroup(of: Bool.self) { group in
                    for capture in batch {
                        group.addTask { @MainActor in
                            defer { self.uploadProgress.removeValue(forKey: capture.id) }
                            do {
                                try await self.uploadCapture(capture, api: api, resumable: resumable, chunkLimit: chunkLimit)
                                return false
                            } catch let failure as ClientError {
                                switch failure {
                                case .uploadTooLarge, .unsupportedMedia, .uploadEmpty, .idempotencyConflict:
                                    try self.queue.blockUpload(failure.message, for: capture.id)
                                    self.uploadMessage = failure.message
                                    return true
                                default: throw failure
                                }
                            }
                        }
                    }
                    var blocked = false
                    for try await didBlock in group { blocked = blocked || didBlock }
                    return blocked
                }
                if blocked && batch.count == 1 { return finalAttemptID != nil }
                retryDelay = 2
                retryUploadAt = nil
                if finalAttemptID != nil { return true }
            }
            if finalAttemptID == nil { try await uploadFullRecordings(api: api) }
            if !pendingCaptures.contains(where: { $0.uploadBlocked != nil }) {
                uploadMessage = unsyncedVideoCount == 0 ? "All videos synced." : "Some videos need attention and have not synced."
            }
        } catch {
            if Task.isCancelled || error is CancellationError || (error as? URLError)?.code == .cancelled { return false }
            let failure = error as? ClientError ?? .network
            uploadMessage = failure.message
            switch failure {
            case .unauthorized:
                handle(failure)
            case .rateLimited(let seconds): retryUploadAt = Date().addingTimeInterval(seconds)
            case .quotaExceeded: retryUploadAt = Date().addingTimeInterval(60)
            case .storage:
                retryUploadAt = .distantFuture
            default:
                retryUploadAt = Date().addingTimeInterval(retryDelay)
                retryDelay = min(60, retryDelay * 2)
            }
            switch failure {
            case .unauthorized, .rateLimited, .storage: return false
            default: return finalAttemptID != nil
            }
        }
        return false
    }

    private func uploadCapture(_ capture: QueuedCapture, api: CollectorAPI, resumable: Bool, chunkLimit: Int) async throws {
        let folder = queue.episodeFolder(for: capture)
        let receipt = try await authorized { token in
            do {
                return try await api.uploaded(captureID: capture.id, token: token)
            } catch ClientError.missingMedia {
                let progress: @MainActor @Sendable (Int64, Int64) -> Void = { [weak self] sent, expected in
                    guard let self, self.uploadProgress[capture.id] != nil, expected > 0 else { return }
                    self.sentByCapture[capture.id] = min(expected, sent)
                    self.uploadProgress[capture.id] = min(1, Double(sent) / Double(expected))
                    self.lastProgressAt = Date()
                    if let start = self.transferStarted, Date().timeIntervalSince(start) >= 1 {
                        self.uploadBytesPerSecond = Double(self.sentByCapture.values.reduce(0, +)) / Date().timeIntervalSince(start)
                    }
                }
                if let folder {
                    if resumable {
                        return try await api.uploadResumableEpisode(directory: folder, episodeID: capture.id, token: token,
                                                                   chunkLimit: chunkLimit, progress: progress)
                    }
                    return try await api.uploadEpisode(directory: folder, episodeID: capture.id, token: token, progress: progress)
                }
                return try await api.upload(file: queue.file(for: capture), captureID: capture.id, token: token, progress: progress)
            }
        }
        let size = try queue.storedSize(for: capture)
        guard receipt.clientCaptureID == capture.id, receipt.sizeBytes == size else { throw ClientError.invalidResponse }
        if let folder {
            let digest = try await Task.detached(priority: .utility) { try CaptureQueue.episodeDigest(folder: folder) }.value
            guard receipt.episodeBundleSHA256 == digest else { throw ClientError.idempotencyConflict }
        }
        try Task.checkCancellation()
        try queue.record(receipt, for: capture.id)
    }

    var pendingCaptures: [QueuedCapture] { currentCaptures.filter { $0.receipt == nil } }
    var unsyncedVideoCount: Int {
        guard let configuration, let credential else { return pendingCaptures.count }
        return pendingCaptures.count + queue.untrackedVideoCount(origin: configuration.publicOrigin, installationID: credential.installationID)
    }
    var syncProgress: Double {
        let count = currentCaptures.count
        return count == 0 ? 1 : min(1, (Double(count - pendingCaptures.count) + uploadProgress.values.reduce(0, +)) / Double(count))
    }
    var estimatedUploadTime: String {
        guard !pendingCaptures.contains(where: { $0.uploadBlocked != nil }) else { return "Some videos need attention. Time remaining unknown." }
        guard !uploadProgress.isEmpty, let speed = uploadBytesPerSecond, speed > 0,
              let lastProgressAt, Date().timeIntervalSince(lastProgressAt) < 10 else { return "Time remaining unknown—waiting for connection." }
        let bytes = pendingCaptures.reduce(Double(0)) { sum, capture in
            sum + Double(capture.sizeBytes ?? 0) * (1 - (uploadProgress[capture.id] ?? 0))
        }
        guard bytes > 0 else { return "Time remaining unknown." }
        let seconds = max(1, Int(ceil(bytes / speed)))
        return seconds < 60 ? "About \(seconds) seconds remaining." : "About \(Int(ceil(Double(seconds) / 60))) minutes remaining."
    }
    var endSessionWarning: String {
        if cleanup.activeID != nil || cleanup.records.contains(where: \.needsSync) {
            return "Cleanup details or route data remain active or unsynced. Ending permanently deletes local session data and deactivates this installation. Stop the cleanup walk and let its details sync first to retain them."
        }
        if queue.storageUnavailable { return "Private storage is unavailable. Do not end the session until it can be checked." }
        if fullFolders.contains(where: { !FileManager.default.fileExists(atPath: $0.appendingPathComponent("uploaded.json").path) }) { return "Full recordings remain on this iPhone. Ending now permanently deletes them and deactivates this installation." }
        if unsyncedVideoCount == 0 { return "All videos synced. This deactivates this installation and deletes local session videos. You’ll need a new invite." }
        return "\(unsyncedVideoCount) videos haven’t uploaded. \(estimatedUploadTime) Stay on the dashboard to finish. Ending now permanently deletes these videos from this device and deactivates this installation."
    }

    /// Explicit full-record start joins an existing walk; stopping recording never ends it.
    func ensureCleanupWalkForRecording() throws -> UUID {
        guard let owner = captureOwner else { throw ClientError.configuration }
        let directory = try queue.recordingDirectory(origin: owner.origin, installationID: owner.installationID)
        try cleanup.bind(directory: directory)
        if cleanup.activeID == nil { try cleanup.start() }
        guard let id = cleanup.activeID else { throw ClientError.storage }
        return id
    }

    func refreshFullRecordings() {
        let values = fullFolders.compactMap(FullSessionRecording.read).sorted { $0.createdAt > $1.createdAt }
        if fullRecordings != values { fullRecordings = values }
    }

    var fullRecordingGroups: [FullRecordingGroup] {
        FullRecordingGroup.make(recordings: fullRecordings, walks: cleanup.records)
    }

    func squeezeRecordings(in full: FullSessionRecording) -> [QueuedCapture] {
        currentCaptures.filter { full.contains($0, queue: queue) }
    }

    var supportsBackendFullRecordingDeletion: Bool {
        phase == .authorized && installation?.developmentSession == true && installation?.developmentContinuousDeleteVersion == 1
    }

    func deleteFullRecording(_ id: UUID, fromBackend: Bool) async -> String? {
        let retry = "Wait for recording and uploads to finish, then try again."
        guard canDeleteLocalCapture, uploadTask == nil, retentionTask == nil else { return retry }
        guard let folder = fullFolders.first(where: { FullSessionRecording.read($0)?.id == id }),
              let full = FullSessionRecording.read(folder) else { return "Recording is no longer available on this iPhone." }
        guard full.finalized else { return retry }
        if fromBackend && (!supportsBackendFullRecordingDeletion || !full.uploaded) { return "A synced recording and development login are required." }
        isDeletingCapture = true
        defer { isDeletingCapture = false; refreshFullRecordings(); kickUploads() }
        guard !(await BackgroundUploads.shared.activeCaptureIDs()).contains(id) else { return retry }
        if fromBackend {
            guard let api else { return ClientError.network.message }
            do { try await authorized { try await api.deleteContinuous(recordingID: id, token: $0) } }
            catch { return Self.deletionFailureMessage(error) }
        }
        do {
            try BackgroundUploads.shared.removeStaged(captureIDs: [id])
            // Each squeeze episode is a sibling, never a child of this directory.
            try FileManager.default.removeItem(at: folder)
            return nil
        } catch { return fromBackend ? "Backend copy deleted. Retry to remove the local recording." : "Could not delete the local recording. Please retry." }
    }

    func prepareFullRecordings() {
        guard let owner = captureOwner,
              let folder = try? queue.recordingDirectory(origin: owner.origin, installationID: owner.installationID),
              preparedFullOwners.insert(folder).inserted else { return }
        do { try ContinuousCapture.recover(in: folder) }
        catch { fullRecordingUploadMessage = "Partial full recordings retained; recovery needs attention." }
    }

    private var fullFolders: [URL] {
        guard let owner = captureOwner,
              let folder = try? queue.recordingDirectory(origin: owner.origin, installationID: owner.installationID),
              let contents = try? FileManager.default.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil) else { return [] }
        return contents.filter { $0.lastPathComponent.hasPrefix("continuous-") && UUID(uuidString: String($0.lastPathComponent.dropFirst(11))) != nil }.sorted { $0.lastPathComponent < $1.lastPathComponent }
    }
    private var pendingFullFolders: [URL] {
        fullFolders.filter { !FileManager.default.fileExists(atPath: $0.appendingPathComponent("uploaded.json").path) && (try? ContinuousCapture.fileNames($0)) != nil }
    }
    private func uploadFullRecordings(api: CollectorAPI) async throws {
        guard installation?.continuousRecordingContractVersion == 1 else {
            if !pendingFullFolders.isEmpty { fullRecordingUploadMessage = "Full recordings saved; this server needs an update to sync them." }
            return
        }
        for folder in pendingFullFolders {
            guard mayStartUpload, !isEndingSession else { return }
            try Task.checkCancellation()
            let id = UUID(uuidString: String(folder.lastPathComponent.dropFirst(11)))!
            fullRecordingUploadMessage = "Uploading full recording…"
            do {
                let receipt = try await authorized { token in
                    try await api.uploadContinuous(directory: folder, recordingID: id, token: token) { [weak self] sent, total in
                        self?.fullRecordingUploadMessage = "Full recording: \(total > 0 ? Int(Double(sent) / Double(total) * 100) : 0)% uploaded"
                    }
                }
                let (digest, size) = try await Task.detached(priority: .utility) { try LiveCollectorAPI.continuousDigest(folder) }.value
                guard receipt.complete, receipt.recording_id == id, receipt.bundle_sha256 == digest, receipt.size_bytes == size else { throw ClientError.idempotencyConflict }
                let data = try JSONEncoder().encode(receipt)
                let ack = folder.appendingPathComponent("uploaded.json")
                try data.write(to: ack, options: .atomic); try CaptureQueue.protect(ack)
                fullRecordingUploadMessage = "Full recording uploaded."
            } catch {
                let cancelled = Task.isCancelled || error is CancellationError || (error as? URLError)?.code == .cancelled
                let created = (try? folder.resourceValues(forKeys: [.creationDateKey]))?.creationDate
                let active = await BackgroundUploads.shared.activeCaptureIDs()
                if !cancelled, !isEndingSession, let created, Date().timeIntervalSince(created) >= 72 * 3600, !active.contains(id) {
                    // This was the final receipt-first/resumable attempt; no OS transfer
                    // may still own the files when the original retention policy runs.
                    try FileManager.default.removeItem(at: folder)
                    fullRecordingUploadMessage = "Expired full recording cleared after its final sync attempt."
                    continue
                }
                fullRecordingUploadMessage = "Full recording waiting to resume; files retained."
                throw error
            }

        }
        try await clearConfirmedFullRecordings()
    }

    private var hasExpiredConfirmedFullRecording: Bool {
        fullFolders.contains { folder in
            let ack = folder.appendingPathComponent("uploaded.json")
            return (try? ack.resourceValues(forKeys: [.contentModificationDateKey])).flatMap(\.contentModificationDate).map { Date().timeIntervalSince($0) >= 24 * 3600 } ?? false
        }
    }
    private func clearConfirmedFullRecordings() async throws {
        for folder in fullFolders {
            let ack = folder.appendingPathComponent("uploaded.json")
            if let modified = try? ack.resourceValues(forKeys: [.contentModificationDateKey]).contentModificationDate,
               Date().timeIntervalSince(modified) >= 24 * 3600 {
                let ids = await BackgroundUploads.shared.activeCaptureIDs()
                guard let id = UUID(uuidString: String(folder.lastPathComponent.dropFirst(11))), !ids.contains(id) else { continue }
                try FileManager.default.removeItem(at: folder)
            }
        }
    }

    var fullRecordingSummary: String? {
        let folders = fullFolders
        guard !folders.isEmpty else { return nil }
        let synced = folders.filter { FileManager.default.fileExists(atPath: $0.appendingPathComponent("uploaded.json").path) }.count
        return "Full recordings: \(synced) uploaded · \(folders.count - synced) pending"
    }

    func syncTick() {
        refreshFullRecordings()
        kickUploads()
        Task { await syncCleanup() }
    }
    func syncCleanup() async {
        guard !cleanupSyncing, phase == .authorized, !isEndingSession, let api,
              installation?.cleanupSessionContractVersion == 1, Date().timeIntervalSince(lastCleanupSync) >= 10,
              let owner = captureOwner else { return }
        cleanupSyncing = true; lastCleanupSync = Date()
        defer { cleanupSyncing = false }
        var sending: CleanupSessionRecord?
        do {
            for record in cleanup.records.filter(\.needsSync) {
                sending = record; cleanup.beginSync(record.id)
                let receipt = try await authorized { try await api.saveCleanup(record, token: $0) }
                guard captureOwner?.installationID == owner.installationID, captureOwner?.origin == owner.origin else { return }
                guard receipt.saved, receipt.session_id == record.id, receipt.revision == record.revision else { throw ClientError.invalidResponse }
                try cleanup.acknowledge(id: record.id, revision: record.revision)
            }
        } catch {
            if let sending, captureOwner?.installationID == owner.installationID, captureOwner?.origin == owner.origin {
                cleanup.failSync(sending.id, revision: sending.revision)
            }
            // Durable records retry with the next foreground/route tick.
        }
    }
    func requestWatchSync() {
        retryUploadAt = nil
        kickUploads()
    }
    var endCleanupPending: Bool { credential?.endingSession == true }

    private var mayStartUpload: Bool {
        foreground || uploadBackgroundTask != .invalid
    }

    private var hasEligibleAutomaticUpload: Bool {
        automaticUploads && hasBootstrapped && phase == .authorized && !isEndingSession &&
            !isDeletingCapture && !busy && retentionTask == nil && uploadTask == nil &&
            (pendingCaptures.contains(where: { $0.uploadBlocked == nil && !$0.isExpired(at: Date()) }) ||
             (installation?.continuousRecordingContractVersion == 1 && !pendingFullFolders.isEmpty)) &&
            (retryUploadAt.map { $0 <= Date() } ?? true)
    }

    private func kickUploads() {
        guard automaticUploads, hasBootstrapped else { return }
        checkRetention()
        guard mayStartUpload, hasEligibleAutomaticUpload else { return }
        if foreground {
            requestedUploadBackgroundTime = false
            requestUploadBackgroundTime()
        }
        uploadTask = Task { [weak self] in
            guard let self else { return }
            defer {
                self.uploadTask = nil
                self.endUploadBackgroundTime()
            }
            if self.mayStartUpload { await self.uploadPending() }
        }
    }

    private func requestUploadBackgroundTime() {
        guard uploadBackgroundTask == .invalid, !requestedUploadBackgroundTime else { return }
        requestedUploadBackgroundTime = true
        uploadBackgroundTask = UIApplication.shared.beginBackgroundTask(withName: "Upload session videos") { [weak self] in
            // Leave any admitted file transfer with the system's background URL session.
            self?.endUploadBackgroundTime()
        }
    }

    private func endUploadBackgroundTime() {
        guard uploadBackgroundTask != .invalid else { return }
        let task = uploadBackgroundTask
        uploadBackgroundTask = .invalid
        UIApplication.shared.endBackgroundTask(task)
    }

    @discardableResult
    func checkRetention() -> Task<Void, Never>? {
        let now = Date()
        guard foreground, !busy, !isEndingSession, !isUploading, !isDeletingCapture, uploadTask == nil, retentionTask == nil,
              !queue.storageUnavailable, now >= nextRetentionCheck else { return nil }
        nextRetentionCheck = now.addingTimeInterval(60)
        do { try queue.prepareRetention(now: now) }
        catch {
            uploadMessage = "Could not update local video retention. The app will retry."
            return nil
        }
        let expired = queue.expiredCaptures(now: now)
        guard !expired.isEmpty || hasExpiredConfirmedFullRecording else { return nil }
        retentionTask = Task { [weak self] in
            guard let self else { return }
            defer {
                self.retentionTask = nil
                self.kickUploads()
            }
            // Also protect transfers restored by iOS after an app relaunch.
            let activeIDs = await BackgroundUploads.shared.activeCaptureIDs()
            guard !Task.isCancelled, self.foreground else { return }
            do { try await self.clearConfirmedFullRecordings() }
            catch { self.fullRecordingUploadMessage = "Could not clear expired full recordings; will retry." }
            for candidate in expired where !activeIDs.contains(candidate.id) {
                guard !Task.isCancelled, self.foreground else { return }
                guard let capture = self.queue.captures.first(where: { $0.id == candidate.id }) else { continue }
                if capture.receipt == nil && capture.uploadBlocked == nil {
                    guard self.currentCaptures.contains(where: { $0.id == capture.id }),
                          self.retryUploadAt.map({ $0 <= Date() }) ?? true,
                          await self.uploadPending(finalAttemptID: capture.id) else { continue }
                }
                guard !Task.isCancelled, self.foreground else { return }
                // A verified receipt starts a new 24-hour window.
                let cleanupTime = Date()
                guard self.queue.captures.first(where: { $0.id == capture.id })?.isExpired(at: cleanupTime) == true else { continue }
                do {
                    try BackgroundUploads.shared.removeStaged(captureIDs: [capture.id])
                    try self.queue.removeExpired(ids: [capture.id], now: cleanupTime)
                } catch {
                    self.uploadMessage = "Could not clear all expired local videos. The app will retry."
                }
            }
        }
        return retentionTask
    }

    private func recoverUpload(request: URLRequest, data: Data, response: HTTPURLResponse) {
        guard response.statusCode == 202,
              response.value(forHTTPHeaderField: "Content-Type")?.hasPrefix("application/json") == true,
              let key = request.value(forHTTPHeaderField: "Idempotency-Key"), let id = UUID(uuidString: key),
              let capture = queue.captures.first(where: { $0.id == id }),
              capture.episodeDirectory == nil,
              request.url == URL(string: capture.origin)?.appendingPathComponent(capture.episodeDirectory == nil ? "api/v1/media" : "api/v1/episodes"),
              let receipt = try? JSONDecoder().decode(MediaReceipt.self, from: data), receipt.clientCaptureID == id,
              let size = try? queue.storedSize(for: capture), size == receipt.sizeBytes else { return }
        do { try queue.record(receipt, for: id) }
        catch { uploadMessage = "Upload confirmed, but local sync metadata needs attention. Videos retained." }
    }

    var canDeleteLocalCapture: Bool {
        phase == .authorized && !busy && !isUploading && !isEndingSession && !isDeletingCapture && !queue.storageUnavailable
    }

    var supportsBackendVideoDeletion: Bool {
        phase == .authorized && installation?.developmentSession == true && installation?.developmentVideoDeleteVersion == 1
    }

    func deleteLocalCapture(_ id: UUID) async -> Bool {
        await deleteCapture(id, fromBackend: false) == nil
    }

    func deleteCaptureHereAndBackend(_ id: UUID) async -> String? {
        await deleteCapture(id, fromBackend: true)
    }

    private func deleteCapture(_ id: UUID, fromBackend: Bool) async -> String? {
        let retryMessage = "Wait for any upload to finish, then try again."
        guard canDeleteLocalCapture, uploadTask == nil, retentionTask == nil,
              let owner = captureOwner else { return retryMessage }
        guard let capture = currentCaptures.first(where: { $0.id == id }) else { return nil }
        if fromBackend {
            guard supportsBackendVideoDeletion else { return ClientError.developmentRequired.message }
            guard capture.receipt?.clientCaptureID == id else { return "Wait for this video to sync, then try again." }
        }
        isDeletingCapture = true
        defer {
            isDeletingCapture = false
            kickUploads()
        }
        // iOS can restore a transfer that has no in-memory upload task.
        let activeIDs = await BackgroundUploads.shared.activeCaptureIDs()
        guard !activeIDs.contains(id) else { return retryMessage }
        if fromBackend {
            guard let api else { return ClientError.network.message }
            do { try await authorized { try await api.deleteVideo(captureID: id, token: $0) } }
            catch { return Self.deletionFailureMessage(error) }
        }
        do {
            try BackgroundUploads.shared.removeStaged(captureIDs: [id])
            try queue.removeLocalCapture(id: id, origin: owner.origin, installationID: owner.installationID)
            return nil
        } catch {
            return fromBackend ? "The backend copy was deleted. Retry to remove the copy on this iPhone." : retryMessage
        }
    }

    static func deletionFailureMessage(_ error: Error) -> String {
        let ns = error as NSError
        // Error domains/codes are diagnostic; never persist tokens or request bodies.
        UserDefaults.standard.set("\(ns.domain):\(ns.code)", forKey: "lastDeletionError")
        if let client = error as? ClientError { return client.message }
        if let url = error as? URLError {
            return "Could not reach the selected server (network \(url.code.rawValue)). Check Tailscale and retry. Your local recording is retained."
        }
        return "The server response could not be verified. Your local recording is retained; please retry."
    }

    private func signoutCaptureIDs(origin: URL, installationID: UUID) throws -> Set<UUID> {
        // Recovery can run after server revocation, before /me validation. Use
        // the saved credential's owner, not an authenticated captureOwner.
        let folder = try queue.recordingDirectory(origin: origin, installationID: installationID)
        let full = try FileManager.default.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil)
            .filter { $0.lastPathComponent.hasPrefix("continuous-") }
            .compactMap { UUID(uuidString: String($0.lastPathComponent.dropFirst(11))) }
        return Set(queue.matching(origin: origin, installationID: installationID).map(\.id)).union(full)
    }

    func endSession() async -> Bool {
        guard !busy, !isEndingSession, !isDeletingCapture, retentionTask == nil, let configuration, let api, var current = credential else { return false }
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
            endingSessionStage = "Stopping uploads…"
            credentialRefresh?.cancel()
            let pendingUpload = uploadTask
            pendingUpload?.cancel()
            let ownedIDs = try signoutCaptureIDs(origin: configuration.publicOrigin, installationID: current.installationID)
            if !ownedIDs.isEmpty || pendingUpload != nil {
                try await OperationDeadline.run(seconds: endOperationTimeout) {
                    if !ownedIDs.isEmpty { await BackgroundUploads.shared.cancel(captureIDs: ownedIDs, origin: configuration.publicOrigin) }
                    await pendingUpload?.value
                }
            }
            try Task.checkCancellation()
            uploadTask = nil
            if current.revocationConfirmed != true {
                endingSessionStage = "Confirming sign-out…"
                let refreshToken = current.refreshToken
                let result = try await OperationDeadline.run(seconds: endOperationTimeout) {
                    try await api.endSession(refreshToken: refreshToken)
                }
                try Task.checkCancellation()
                guard result.revoked, result.installationID == current.installationID else { throw ClientError.invalidResponse }
                current.revocationConfirmed = true
                try vault.save(current, origin: configuration.publicOrigin)
                credential = current
            }
            let captureIDs = try signoutCaptureIDs(origin: configuration.publicOrigin, installationID: current.installationID)
            endingSessionStage = "Checking stopped uploads…"
            if !captureIDs.isEmpty {
                let activeIDs = try await OperationDeadline.run(seconds: endOperationTimeout) {
                    await BackgroundUploads.shared.activeCaptureIDs()
                }
                try Task.checkCancellation()
                guard activeIDs.isDisjoint(with: captureIDs) else { throw ClientError.storage }
            }
            endingSessionStage = "Clearing local copies…"
            try BackgroundUploads.shared.removeStaged(captureIDs: captureIDs)
            cleanup.pauseForAccountChange()
            try queue.removeSession(origin: configuration.publicOrigin, installationID: current.installationID)
            try vault.remove(origin: configuration.publicOrigin)
            credential = nil
            hasSavedCredential = false
            installation = nil
            uploadProgress.removeAll()
            retryUploadAt = nil
            phase = .home
            message = "Session ended. Register with a new invite."
            return true
        } catch {
            #if DEBUG
            UserDefaults.standard.set("\((error as NSError).domain):\((error as NSError).code)", forKey: "signoutLastError")
            #endif
            message = "Session cleanup has not finished. Your remaining local videos and credentials are retained. Retry End Session."
            phase = .retry
            return false
        }
    }

    func refreshUploadStatus() async {
        guard !busy, !isDeletingCapture, retentionTask == nil, retryAllowed(), phase == .authorized, let api else { return }
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
        verifiedAdminConfiguration = nil
        availableServers = []
    }

    func suspend() {
        foreground = false
        hideAdmin()
        guard uploadTask != nil || hasEligibleAutomaticUpload else { return }
        requestUploadBackgroundTime()
        kickUploads()
    }

    func resume() {
        foreground = true
        if phase == .authorized && !isEndingSession { cleanup.resumeRouteIfRequested() }
        requestedUploadBackgroundTime = false
        if uploadTask != nil { requestUploadBackgroundTime() }
        nextRetentionCheck = .distantPast
    }

    func probeAdmin() async {
        probeGeneration = UUID()
        let generation = probeGeneration
        guard foreground else { return }
        if discoverAdminServers {
            await probeDiscoveredAdmin(generation: generation)
            return
        }
        let network = adminNetworkConfiguration
        let reachable: Bool
        if let network, network.privateAdminOrigin?.scheme == "https" {
            reachable = await apiFactory(network).adminReachable()
        } else { reachable = false }
        guard foreground, !Task.isCancelled, probeGeneration == generation else { return }
        adminVisible = reachable
        if !reachable, automaticallyUseLocalCollector, phase != .authorized { await useLocalCollector() }
    }

    func refreshServers() async {
        guard !refreshingServers else { return }
        refreshingServers = true
        defer { refreshingServers = false }
        lastCatalogCheck = nil
        await probeAdmin()
    }

    private func probeDiscoveredAdmin(generation: UUID) async {
        let seeds = [adminNetworkConfiguration, configuration, APIConfiguration.savedAdminNetwork(),
                     APIConfiguration.productionNetwork, APIConfiguration.developmentNetwork]
        var candidates: [APIConfiguration] = []
        for candidate in seeds.compactMap({ $0 }) + catalogServers.compactMap(\.configuration) {
            guard candidate.privateAdminOrigin?.scheme == "https",
                  !candidates.contains(where: { $0.privateAdminOrigin == candidate.privateAdminOrigin }) else { continue }
            candidates.append(candidate)
        }
        // These requests contain no collector credentials. Never switch capture origin here.
        let matches = await reachableServers(candidates)
        guard foreground, !Task.isCancelled, probeGeneration == generation else { return }
        let reachable = candidates.filter { matches.contains($0) }
        verifiedAdminConfiguration = reachable.first
        adminVisible = !reachable.isEmpty
        if !reachable.isEmpty,
           lastCatalogCheck.map({ Date().timeIntervalSince($0) >= 60 }) ?? true {
            lastCatalogCheck = Date()
            var loaded = false
            for source in reachable {
                do {
                    let discovered = try await apiFactory(source).availableServers()
                    guard foreground, !Task.isCancelled, probeGeneration == generation else { return }
                    catalogServers = discovered
                    loaded = true
                    serverDiscoveryMessage = discovered.isEmpty ? "No server list published. Known servers are checked below." : "Only reachable servers are listed."
                    break
                } catch {
                    guard foreground, !Task.isCancelled, probeGeneration == generation else { return }
                }
            }
            if !loaded { serverDiscoveryMessage = "Couldn’t load the server list. Known servers and manual addresses remain available." }
        }
        let additional = catalogServers.compactMap(\.configuration).filter { item in
            !candidates.contains(where: { $0.privateAdminOrigin == item.privateAdminOrigin })
        }
        let extraMatches = await reachableServers(additional)
        guard foreground, !Task.isCancelled, probeGeneration == generation else { return }
        availableServers = (reachable + extraMatches).map { config in
            catalogServers.first(where: { $0.configuration?.privateAdminOrigin == config.privateAdminOrigin }) ?? .known(config)
        }.filter { $0.isValid(inTailnetOf: APIConfiguration.productionNetwork.privateAdminOrigin!) }
        if !adminVisible { serverDiscoveryMessage = "No private admin server is reachable. Check Tailscale connectivity and access." }
    }

    private func reachableServers(_ candidates: [APIConfiguration]) async -> [APIConfiguration] {
        await withTaskGroup(of: (APIConfiguration, Bool).self) { group in
            for candidate in candidates {
                let client = apiFactory(candidate)
                group.addTask { (candidate, await client.adminReachable()) }
            }
            var matches: [APIConfiguration] = []
            for await (candidate, reachable) in group where reachable { matches.append(candidate) }
            return matches
        }
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
        if discoverAdminServers { return verifiedAdminConfiguration?.privateAdminOrigin }
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
