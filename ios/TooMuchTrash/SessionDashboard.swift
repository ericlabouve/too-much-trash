import SwiftUI
import AVKit

struct AdminActions: View {
    @ObservedObject var account: AccountSession
    @Binding var showConfiguration: Bool
    @Environment(\.openURL) private var openURL

    var body: some View {
        Menu("Admin") {
            Button("Admin login", systemImage: "arrow.up.right.square") {
                Task { if let url = await account.verifiedAdminURL() { openURL(url) } }
            }.accessibilityIdentifier("adminLogin")
            Button("Server addresses", systemImage: "gear") { showConfiguration = true }
                .accessibilityIdentifier("serverAddresses")
        }.accessibilityIdentifier("adminMenu")
    }
}

struct SessionDashboard: View {
    @ObservedObject var account: AccountSession
    @ObservedObject var queue: CaptureQueue
    @Environment(\.dismiss) private var dismiss
    @State private var showConfiguration = false
    @State private var confirmEnd = false
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Button("Back to camera", systemImage: "camera") { dismiss() }
                        .buttonStyle(.borderedProminent).frame(maxWidth: .infinity)
                        .accessibilityIdentifier("backToCamera")
                    SyncIndicator(account: account, queue: queue)
                    if account.isEndingSession { ProgressView("Ending session…") }
                    Text("Session videos").font(.headline)
                    if account.currentCaptures.isEmpty {
                        ContentUnavailableView("No videos yet", systemImage: "video")
                    } else {
                        LazyVGrid(columns: columns, spacing: 14) {
                            ForEach(account.currentCaptures.reversed()) { capture in
                                SessionVideoTile(capture: capture, file: queue.file(for: capture), uploading: account.uploadingID == capture.id, stopPlayback: account.isEndingSession)
                            }
                        }
                    }
                }.padding(18).disabled(account.isEndingSession)
            }
            .navigationTitle("Dashboard").navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 14) {
                        if account.adminVisible { AdminActions(account: account, showConfiguration: $showConfiguration) }
                        Button(role: .destructive) { confirmEnd = true } label: {
                            Text("End Session").foregroundStyle(.red)
                        }
                            .tint(.red)
                            .disabled(account.busy || queue.storageUnavailable || account.installation?.mediaContractVersion != 1)
                            .accessibilityIdentifier("endSession")
                    }
                }
            }
            .sheet(isPresented: $showConfiguration) { ServerConfigurationView(account: account) }
            .onChange(of: account.adminVisible) { _, visible in if !visible { showConfiguration = false } }
            .alert("End session?", isPresented: $confirmEnd) {
                Button(account.unsyncedVideoCount == 0 ? "Cancel" : "Keep uploading", role: .cancel) {}
                Button(account.unsyncedVideoCount == 0 ? "End Session" : "End & Delete", role: .destructive) {
                    Task { if await account.endSession() { dismiss() } }
                }
            } message: { Text(account.endSessionWarning) }
        }
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
