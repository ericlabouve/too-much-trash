import SwiftUI

struct ContentView: View {
    @StateObject private var camera = CameraController()
    @EnvironmentObject private var account: AccountSession
    @Environment(\.scenePhase) private var scenePhase
    @State private var screenButtonHeld = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            CameraPreview(camera: camera).ignoresSafeArea()
            VStack(spacing: 20) {
                HStack {
                    Button { account.returnHome() } label: { Image(systemName: "chevron.left") }
                        .accessibilityLabel("Home")
                    Label("FIELD CAMERA", systemImage: "viewfinder")
                        .font(.caption.weight(.semibold))
                    Spacer()
                    if let clip = camera.latestClip {
                        ShareLink(item: clip) { Image(systemName: "square.and.arrow.up") }
                            .accessibilityLabel("Share last recording")
                    }
                }
                .padding(16)
                .background(.black.opacity(0.55), in: Capsule())
                Spacer()
                UploadPanel(account: account, queue: account.queue)
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
                    } else {
                        Text(camera.isReady ? camera.status : "Camera required to record")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                    }
                    Button {} label: {
                        Circle()
                            .fill(camera.recordingStartedAt == nil ? Color.white : Color.red)
                            .frame(width: 64, height: 64)
                            .padding(7)
                            .overlay(Circle().stroke(.white, lineWidth: 3))
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
                    Text("Hold either volume button to record\nRelease to save · Video only")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white.opacity(0.8))
                }
                .padding(24)
                .frame(maxWidth: .infinity)
                .background(.black.opacity(0.6), in: RoundedRectangle(cornerRadius: 28))
            }
            .padding(20)
        }
        .foregroundStyle(.white)
        .task { [account] in
            let owner = account.captureOwner
            camera.onClipSaved = { [weak account] file in account?.queueCapture(file, owner: owner) }
            await camera.activate()
        }
        .onChange(of: scenePhase) { _, phase in
            if phase == .active {
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
