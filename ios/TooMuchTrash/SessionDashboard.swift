import SwiftUI
import AVKit

struct AdminActions: View {
    @ObservedObject var account: AccountSession
    @Binding var showConfiguration: Bool
    @Environment(\.openURL) private var openURL
    @State private var showCameraSettings = false

    var body: some View {
        Menu("Admin") {
            Button("Admin login", systemImage: "arrow.up.right.square") {
                Task { if let url = await account.verifiedAdminURL() { openURL(url) } }
            }.accessibilityIdentifier("adminLogin")
            Button("Camera view", systemImage: "camera") { showCameraSettings = true }
                .accessibilityIdentifier("cameraSettings")
            Button("Server addresses", systemImage: "gear") { showConfiguration = true }
                .accessibilityIdentifier("serverAddresses")
        }.accessibilityIdentifier("adminMenu")
            .sheet(isPresented: $showCameraSettings) {
                CameraSettingsView(settings: account.cameraSettings)
                    .onChange(of: account.adminVisible) { _, visible in if !visible { showCameraSettings = false } }
            }
    }
}

struct SessionDashboard: View {
    @ObservedObject var account: AccountSession
    @ObservedObject var queue: CaptureQueue
    @ObservedObject var camera: EpisodeCameraController
    @Environment(\.dismiss) private var dismiss
    @State private var showConfiguration = false
    @State private var confirmEnd = false
    @State private var showCleanup = false
    @State private var confirmDelete = false
    @State private var fullToDelete: FullSessionRecording?
    @State private var confirmFullDelete = false
    @State private var captureToDelete: QueuedCapture?
    @State private var deleteFromBackend = false
    @State private var showDeleteFailure = false
    @State private var deleteFailure = ""
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Button("Back to camera", systemImage: "camera") { dismiss() }
                        .buttonStyle(.borderedProminent).frame(maxWidth: .infinity)
                        .accessibilityIdentifier("backToCamera")
                    if camera.fullRecording || camera.fullRecordingChanging {
                        FullSessionRecordingControl(active: camera.fullRecording, changing: camera.fullRecordingChanging, ready: false,
                                                    start: {}, stop: { camera.setFullRecording(false) })
                    }
                    SyncIndicator(account: account, queue: queue)
                    if !account.fullRecordings.isEmpty {
                        Text("Full Session Recordings").font(.headline)
                        ForEach(account.fullRecordingGroups) { group in
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text(group.name).font(.subheadline.bold())
                                    if let date = group.startedAt { Text(date, style: .date).font(.caption).foregroundStyle(.secondary) }
                                }
                                ForEach(group.recordings) { full in
                            NavigationLink {
                                FullRecordingDetail(account: account, queue: queue, full: full) { capture, backend in
                                    captureToDelete = capture; deleteFromBackend = backend; confirmDelete = true
                                }
                            } label: { FullRecordingRow(full: full, clips: account.squeezeRecordings(in: full).count) }
                            .buttonStyle(.plain)
                            .contextMenu {
                                Button("Delete", systemImage: "trash", role: .destructive) {
                                    fullToDelete = full; deleteFromBackend = false; confirmFullDelete = true
                                }.disabled(!account.canDeleteLocalCapture || !full.finalized)
                                if account.supportsBackendFullRecordingDeletion && full.uploaded {
                                    Button("Delete here and backend", systemImage: "trash", role: .destructive) {
                                        fullToDelete = full; deleteFromBackend = true; confirmFullDelete = true
                                    }.disabled(!account.canDeleteLocalCapture || !full.finalized)
                                }
                            }
                                }
                            }
                        }
                    }
                    if !account.fullRecordingUploadMessage.isEmpty { Text(account.fullRecordingUploadMessage).font(.callout) }
                    if account.isEndingSession { ProgressView(account.endingSessionStage) }
                    Text("Session Squeeze Event Recordings").font(.headline)
                    if account.currentCaptures.isEmpty {
                        ContentUnavailableView("No videos yet", systemImage: "video")
                    } else {
                        LazyVGrid(columns: columns, spacing: 14) {
                            ForEach(account.currentCaptures.reversed()) { capture in
                                SessionVideoTile(capture: capture, file: queue.file(for: capture),
                                                 uploading: account.uploadProgress[capture.id] != nil,
                                                 stopPlayback: account.isEndingSession,
                                                 canDelete: account.canDeleteLocalCapture,
                                                 showsBackendDelete: account.supportsBackendVideoDeletion && capture.receipt?.clientCaptureID == capture.id) { fromBackend in
                                    captureToDelete = capture
                                    deleteFromBackend = fromBackend
                                    confirmDelete = true
                                }
                            }
                        }
                    }
                }.padding(18).disabled(account.isEndingSession)
            }
            .navigationTitle("Dashboard").navigationBarTitleDisplayMode(.inline)
            .task {
                while !Task.isCancelled {
                    account.refreshFullRecordings()
                    do { try await Task.sleep(for: .seconds(1)) } catch { break }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 14) {
                        Menu("Menu") { Button("Cleanup session", systemImage: "leaf") { showCleanup = true } }
                            .accessibilityIdentifier("generalMenu")
                        if account.adminVisible { AdminActions(account: account, showConfiguration: $showConfiguration) }
                        Button(role: .destructive) { confirmEnd = true } label: {
                            Text("Sign out").foregroundStyle(.red)
                        }
                            .tint(.red)
                            .disabled(camera.fullRecording || camera.fullRecordingChanging || account.busy || queue.storageUnavailable || account.installation?.mediaContractVersion != 1)
                            .accessibilityIdentifier("endSession")
                    }
                }
            }
            .onDisappear {
                if account.phase != .authorized { camera.deactivate() }
            }
            .sheet(isPresented: $showCleanup) { CleanupSessionView(store: account.cleanup) }
            .sheet(isPresented: $showConfiguration) { ServerConfigurationView(account: account) }
            .onChange(of: account.adminVisible) { _, visible in if !visible { showConfiguration = false } }
            .alert("Sign out and clear local recordings?", isPresented: $confirmEnd) {
                Button(account.unsyncedVideoCount == 0 ? "Cancel" : "Keep uploading", role: .cancel) {}
                Button(account.unsyncedVideoCount == 0 ? "End Session" : "End & Delete", role: .destructive) {
                    Task { if await account.endSession() { dismiss() } }
                }
            } message: { Text(account.endSessionWarning) }
            .alert(deleteFromBackend ? "Delete here and backend?" : "Delete video from this iphone",
                   isPresented: $confirmDelete, presenting: captureToDelete) { capture in
                Button("Cancel", role: .cancel) {}
                Button("Delete", role: .destructive) {
                    let fromBackend = deleteFromBackend
                    Task {
                        if fromBackend {
                            if let failure = await account.deleteCaptureHereAndBackend(capture.id) {
                                deleteFailure = failure
                                showDeleteFailure = true
                            }
                        } else if !(await account.deleteLocalCapture(capture.id)) {
                            deleteFailure = "Wait for any upload to finish, then try again."
                            showDeleteFailure = true
                        }
                    }
                }
            } message: { _ in
                if deleteFromBackend { Text("This permanently removes the video from this iPhone and the backend.") }
            }
            .alert(deleteFromBackend ? "Delete here and backend?" : "Delete video from this iphone",
                   isPresented: $confirmFullDelete, presenting: fullToDelete) { full in
                Button("Cancel", role: .cancel) {}
                Button("Delete", role: .destructive) {
                    let backend = deleteFromBackend
                    Task {
                        if let failure = await account.deleteFullRecording(full.id, fromBackend: backend) {
                            deleteFailure = failure; showDeleteFailure = true
                        }
                    }
                }
            } message: { _ in
                if deleteFromBackend { Text("Permanently delete this Full Session Recording here and on the backend. Squeeze event recordings are kept.") }
            }
            .alert("Couldn’t delete video", isPresented: $showDeleteFailure) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(deleteFailure)
            }
        }
    }
}

struct FullRecordingRow: View {
    let full: FullSessionRecording
    let clips: Int
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "video.fill").foregroundStyle(.green)
            VStack(alignment: .leading, spacing: 4) {
                Text(full.createdAt, format: .dateTime.month().day().hour().minute()).font(.headline)
                Text("\(Int(full.duration)) sec · \(clips) squeeze event recordings").font(.caption).foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: full.uploaded ? "checkmark.circle.fill" : "clock")
                .foregroundStyle(full.uploaded ? .green : .secondary)
                .accessibilityLabel(full.uploaded ? "Synced" : full.finalized ? "Pending upload" : "Finalizing")
        }.padding(14).background(.regularMaterial, in: RoundedRectangle(cornerRadius: 14))
    }
}

private struct FullRecordingDetail: View {
    @ObservedObject var account: AccountSession
    @ObservedObject var queue: CaptureQueue
    let full: FullSessionRecording
    let onDelete: (QueuedCapture, Bool) -> Void
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                FullRecordingRow(full: full, clips: account.squeezeRecordings(in: full).count)
                Text("Session Squeeze Event Recordings").font(.headline)
                if account.squeezeRecordings(in: full).isEmpty {
                    ContentUnavailableView("No squeeze event recordings", systemImage: "video")
                } else {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                        ForEach(account.squeezeRecordings(in: full).reversed()) { capture in
                            SessionVideoTile(capture: capture, file: queue.file(for: capture),
                                uploading: account.uploadProgress[capture.id] != nil, stopPlayback: account.isEndingSession,
                                canDelete: account.canDeleteLocalCapture,
                                showsBackendDelete: account.supportsBackendVideoDeletion && capture.receipt?.clientCaptureID == capture.id) {
                                    onDelete(capture, $0)
                                }
                        }
                    }
                }
            }.padding(18)
        }.navigationTitle("Full Session Recording").navigationBarTitleDisplayMode(.inline)
    }
}

struct SyncIndicator: View {
    @ObservedObject var account: AccountSession
    @ObservedObject var queue: CaptureQueue
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if queue.storageUnavailable {
                Label("Private video storage needs attention", systemImage: "exclamationmark.triangle")
            } else if account.currentCaptures.isEmpty {
                Text("No videos to sync").foregroundStyle(.secondary)
            } else if account.unsyncedVideoCount == 0 {
                Label("All videos synced", systemImage: "checkmark.circle.fill").foregroundStyle(.green)
                    .accessibilityIdentifier("allVideosSynced")
            } else {
                let sent = account.currentCaptures.count - account.pendingCaptures.count
                Text(account.isUploading ? "Uploading \(sent + 1) of \(account.currentCaptures.count)" : "\(account.pendingCaptures.count) videos waiting to sync")
                ProgressView(value: account.syncProgress).accessibilityIdentifier("syncProgress")
                TimelineView(.periodic(from: .now, by: 1)) { _ in
                    Text(account.isUploading ? account.estimatedUploadTime : account.uploadMessage)
                        .font(.caption).foregroundStyle(.secondary).fixedSize(horizontal: false, vertical: true)
                }
            }
            if account.unsyncedVideoCount > account.pendingCaptures.count {
                Text("Interrupted recordings need review and have not synced.").font(.caption)
            }
        }.accessibilityElement(children: .combine)
    }
}

private struct SessionVideoTile: View {
    let capture: QueuedCapture
    let file: URL
    let uploading: Bool
    let stopPlayback: Bool
    let canDelete: Bool
    let showsBackendDelete: Bool
    let onDelete: (Bool) -> Void
    @State private var player: AVPlayer?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let player {
                InlineVideoPlayer(player: player)
                    .aspectRatio(3 / 4, contentMode: .fit)
            } else {
                Rectangle().fill(.quaternary).aspectRatio(3 / 4, contentMode: .fit)
            }
            HStack {
                Text(capture.createdAt ?? .distantPast, style: .time).font(.caption)
                Spacer()
                Image(systemName: capture.receipt != nil ? "checkmark.circle.fill" : capture.uploadBlocked != nil ? "exclamationmark.triangle" : uploading ? "arrow.up.circle" : "clock")
                    .foregroundStyle(capture.receipt != nil ? .green : .secondary)
                    .accessibilityLabel(capture.receipt != nil ? "Synced" : capture.uploadBlocked ?? (uploading ? "Uploading" : "Pending"))
            }.padding(.horizontal, 10).padding(.bottom, 10)
        }
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 14))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .contentShape(.contextMenuPreview, RoundedRectangle(cornerRadius: 14))
        .contextMenu {
            Button("Delete", systemImage: "trash", role: .destructive) { onDelete(false) }
                .disabled(!canDelete)
            if showsBackendDelete {
                Button("Delete here and backend", systemImage: "trash", role: .destructive) { onDelete(true) }
                    .disabled(!canDelete)
            }
        }
        .task { if player == nil { player = AVPlayer(url: file) } }
        .onDisappear { player?.pause() }
        .onChange(of: stopPlayback) { _, stop in if stop { player?.pause() } }
    }
}

/// Native playback controls provide scrubbing, play/pause, and full screen.
private struct InlineVideoPlayer: UIViewControllerRepresentable {
    let player: AVPlayer
    func makeCoordinator() -> Coordinator { Coordinator(player: player) }
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = true
        controller.allowsPictureInPicturePlayback = false
        controller.videoGravity = .resizeAspect
        let tap = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.toggle))
        tap.cancelsTouchesInView = false
        tap.delegate = context.coordinator
        controller.view.addGestureRecognizer(tap)
        return controller
    }
    func updateUIViewController(_ controller: AVPlayerViewController, context: Context) {
        if controller.player !== player { controller.player = player }
    }
    final class Coordinator: NSObject, UIGestureRecognizerDelegate {
        let player: AVPlayer
        init(player: AVPlayer) { self.player = player }
        @objc func toggle() { player.rate == 0 ? player.play() : player.pause() }
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
            var view = touch.view
            while let current = view {
                if current is UIControl || current.accessibilityTraits.contains(.button) { return false }
                view = current.superview
            }
            return true
        }
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                               shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool { true }
    }
}
