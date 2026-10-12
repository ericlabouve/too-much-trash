import SwiftUI

struct ContentView: View {
    @StateObject private var camera = CameraController()
    @EnvironmentObject private var account: AccountSession
    @Environment(\.scenePhase) private var scenePhase
    @State private var screenButtonHeld = false
    @State private var showDashboard = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            CameraPreview(camera: camera).ignoresSafeArea()
            VStack(spacing: 20) {
                HStack {
                    Label("FIELD CAMERA", systemImage: "viewfinder")
                        .font(.caption.weight(.semibold))
                    Spacer()
                    Button { showDashboard = true } label: { Image(systemName: "square.grid.2x2") }
                        .accessibilityLabel("Dashboard").accessibilityIdentifier("openDashboard")
                        .disabled(camera.recordingStartedAt != nil || camera.isFinishing || camera.isStarting)
                }
                .padding(16)
                .background(.black.opacity(0.55), in: Capsule())
                Spacer()
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
                    Spacer()
                }
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
                    Button {} label: {
                        ZStack {
                            Circle().stroke(lineWidth: 3).frame(width: 78, height: 78)
                            Circle().stroke(lineWidth: 2).frame(width: 64, height: 64)
                        }.foregroundStyle(camera.recordingStartedAt == nil ? .white : .red)
                    }
                    .buttonStyle(.plain)
                    .disabled(!camera.isReady || camera.isFinishing)
                    .opacity(camera.isReady ? 1 : 0.35)
                    .accessibilityLabel("Record video")
                    .accessibilityHint("Hold to record. Release to save.")
                    .accessibilityIdentifier("recordButton")
                    .simultaneousGesture(
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
                .frame(maxWidth: .infinity)
            }
            .padding(20)
        }
        .foregroundStyle(.white)
        .task { [account] in
            let owner = account.captureOwner
            camera.onClipSaved = { [weak account] file in account?.queueCapture(file, owner: owner) }
            guard let owner, let directory = try? account.queue.recordingDirectory(origin: owner.origin, installationID: owner.installationID) else { return }
            camera.setRecordingDirectory(directory)
            await camera.activate()
        }
        .fullScreenCover(isPresented: $showDashboard) { SessionDashboard(account: account, queue: account.queue) }
        .onChange(of: showDashboard) { _, shown in
            if shown { screenButtonHeld = false; camera.deactivate() }
            else { Task { await camera.activate() } }
        }
        .onChange(of: scenePhase) { _, phase in
            if phase == .active && !showDashboard {
                Task { await camera.activate() }
            } else {
                screenButtonHeld = false
                camera.deactivate()
            }
        }
        .onDisappear { camera.deactivate() }
    }
}

#Preview {
    ContentView().environmentObject(AccountSession(configuration: nil))
}
