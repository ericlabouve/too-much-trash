import SwiftUI

struct ContentView: View {
    @StateObject private var camera: EpisodeCameraController
    init(camera: EpisodeCameraController? = nil) { _camera = StateObject(wrappedValue: camera ?? EpisodeCameraController()) }
    @EnvironmentObject private var account: AccountSession
    @Environment(\.scenePhase) private var scenePhase
    @State private var screenButtonHeld = false
    @State private var showDashboard = false
    @State private var showCleanupStart = false
    @State private var pendingFullStart = false
    @State private var fullRecordingError: String?
    @State private var cameraConfiguration = CameraViewConfiguration()

    var body: some View {
        GeometryReader { geometry in
        let landscape = geometry.size.width > geometry.size.height
        ZStack {
            Color.black.ignoresSafeArea()
            EpisodeCameraPreview(camera: camera).ignoresSafeArea()
            if !camera.isReady {
                VStack(spacing: 14) {
                    Image(systemName: "camera").font(.system(size: 36))
                    Text(camera.status)
                        .font(.title3.weight(.semibold))
                        .multilineTextAlignment(.center)
                        .accessibilityIdentifier("cameraStatus")
                    if camera.permissionDenied {
                        Button("Open Settings") {
                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(url)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .padding(28)
                .background(.black.opacity(0.65), in: RoundedRectangle(cornerRadius: 24))
            }
            if camera.isReady, let notice = camera.limitNotice {
                Text(notice)
                    .font(.callout.weight(.semibold))
                    .multilineTextAlignment(.center)
                    .padding(14)
                    .background(.black.opacity(0.75), in: RoundedRectangle(cornerRadius: 14))
                    .accessibilityIdentifier("recordingLimitNotice")
            }
            VStack(spacing: 20) {
                HStack {
                    Label("FIELD CAMERA", systemImage: "viewfinder")
                        .font(.caption.weight(.semibold))
                    Spacer()
                    Button { showDashboard = true } label: { Image(systemName: "square.grid.2x2") }
                        .accessibilityLabel("Dashboard").accessibilityIdentifier("openDashboard")
                        .disabled(camera.recordingStartedAt != nil || camera.pendingEpisodes > 0 || camera.fullRecordingChanging)
                        .accessibilityHint("Full Session Recording continues while the dashboard is open.")
                }
                .padding(16)
                .background(.black.opacity(0.55), in: Capsule())
                if cameraConfiguration.fullRecordingButtonEnabled || camera.fullRecording {
                HStack {
                    FullSessionRecordingControl(active: camera.fullRecording, changing: camera.fullRecordingChanging, ready: camera.isReady) {
                        if account.cleanup.activeID == nil { showCleanupStart = true }
                        else { beginFullRecording() }
                    } stop: { camera.setFullRecording(false) }
                }
                }
                if cameraConfiguration.runsModel && !camera.alphaEvent.isEmpty {
                    Text(camera.alphaEvent).font(.title.bold()).padding(10)
                        .background(.green.opacity(0.8), in: Capsule())
                        .accessibilityIdentifier("jawAlphaEvent")
                }
                Spacer()
                VStack(spacing: 16) {
                    if let start = camera.recordingStartedAt {
                        HStack(spacing: 8) {
                            Circle().fill(.red).frame(width: 9, height: 9)
                            Text("REC")
                            Text(start, style: .timer).monospacedDigit()
                        }
                        .font(.headline)
                        .accessibilityIdentifier("recordingIndicator")
                    }
                    ZStack {
                        Circle().stroke(lineWidth: 3).frame(width: 78, height: 78)
                        Circle().stroke(lineWidth: 2).frame(width: 64, height: 64)
                    }
                    .foregroundStyle(camera.recordingStartedAt == nil ? .white : .red)
                    .contentShape(Circle())
                    .allowsHitTesting(camera.isReady || screenButtonHeld)
                    .opacity(camera.isReady ? 1 : 0.35)
                    .accessibilityLabel("Record video")
                    .accessibilityHint("Hold to record. Release to save.")
                    .accessibilityAddTraits(.isButton)
                    .accessibilityIdentifier("recordButton")
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in
                                guard !screenButtonHeld else { return }
                                screenButtonHeld = true
                                camera.press("screen")
                            }
                            .onEnded { _ in
                                screenButtonHeld = false
                                camera.release("screen")
                            }
                    )
                }
                .padding(24)
                .frame(maxWidth: .infinity, alignment: landscape ? .leading : .center)
            }
            .padding(20)
        }
        }
        .foregroundStyle(.white)
        .accessibilityHidden(showDashboard)
        .task { [account] in
            let owner = account.captureOwner
            camera.onEpisodeSaved = { [weak account] folder, id in account?.queueEpisode(folder, id: id, owner: owner) }
            guard let owner, let directory = try? account.queue.recordingDirectory(origin: owner.origin, installationID: owner.installationID) else { return }
            account.prepareFullRecordings()
            do { try camera.configure(directory: directory) }
            catch { return }
            camera.applyCameraConfiguration(account.cameraSettings.configuration)
            camera.setCleanupSession(account.cleanup.activeID)
            account.cleanup.resumeRouteIfRequested()
            await camera.activate()
        }
        .onReceive(account.cameraSettings.$configuration) { value in
            cameraConfiguration = value
            camera.applyCameraConfiguration(value)
        }
        .onReceive(account.cleanup.$records) { _ in camera.setCleanupSession(account.cleanup.activeID) }
        .modifier(FullRecordingStartFlow(store: account.cleanup, presented: $showCleanupStart) { beginFullRecording() })
        .fullScreenCover(isPresented: $showDashboard) { SessionDashboard(account: account, queue: account.queue, camera: camera) }
        .onChange(of: showDashboard) { _, shown in
            if shown {
                pendingFullStart = false; screenButtonHeld = false
                if !camera.fullRecording { camera.deactivate() }
            }
            else { Task { await camera.activate() } }
        }
        .onChange(of: scenePhase) { _, phase in
            if phase == .active && (!showDashboard || camera.fullRecording) {
                Task { await camera.activate() }
            } else {
                screenButtonHeld = false
                camera.deactivate()
            }
        }
        .onChange(of: camera.isReady) { _, ready in
            if ready, pendingFullStart { pendingFullStart = false; beginFullRecording() }
        }
        .alert("Couldn’t start recording", isPresented: Binding(get: { fullRecordingError != nil }, set: { if !$0 { fullRecordingError = nil } })) {
            Button("OK", role: .cancel) { fullRecordingError = nil }
        } message: { Text(fullRecordingError ?? "") }
        .onDisappear {
            pendingFullStart = false
            if !showDashboard || account.phase != .authorized { camera.deactivate() }
        }
    }
    private func beginFullRecording() {
        guard let id = account.cleanup.activeID else { fullRecordingError = "Start a cleanup walk first."; return }
        guard camera.isReady else {
            pendingFullStart = true
            Task { await camera.activate() }
            return
        }
        pendingFullStart = false
        camera.setCleanupSession(id)
        camera.setFullRecording(true)
    }

}


struct FullSessionRecordingControl: View {
    let active: Bool
    let changing: Bool
    let ready: Bool
    let start: () -> Void
    let stop: () -> Void
    @State private var confirmStop = false
    var body: some View {
        Button(active ? "Stop Full Session Recording" : "Start Full Session Recording") {
            if active { confirmStop = true } else { start() }
        }
        .accessibilityIdentifier("fullSessionRecording")
        .buttonStyle(.bordered).tint(active ? .red : .green)
        .disabled(changing || (!ready && !active))
        .alert("Stop Full Session Recording?", isPresented: $confirmStop) {
            Button("Keep recording", role: .cancel) {}
            Button("Stop recording", role: .destructive) { stop() }
        } message: { Text("Your cleanup walk will stay active.") }
    }
}
