import SwiftUI

struct ContentView: View {
    @StateObject private var camera = EpisodeCameraController()
    @EnvironmentObject private var account: AccountSession
    @Environment(\.scenePhase) private var scenePhase
    @State private var screenButtonHeld = false
    @State private var showDashboard = false

    var body: some View {
        GeometryReader { geometry in
        let landscape = geometry.size.width > geometry.size.height
        ZStack {
            Color.black.ignoresSafeArea()
            EpisodeCameraPreview(camera: camera).ignoresSafeArea()
            if account.showDeveloperSensorOverlay {
                VStack {
                    HStack { DeveloperSensorOverlay(camera: camera, compact: landscape); Spacer() }
                    Spacer()
                }
                .padding(.top, landscape ? 78 : 82).padding(.leading, 16)
                .allowsHitTesting(false)
            }
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
                        .disabled(camera.recordingStartedAt != nil || camera.pendingEpisodes > 0)
                }
                .padding(16)
                .background(.black.opacity(0.55), in: Capsule())
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
        .task { [account] in
            let owner = account.captureOwner
            camera.onEpisodeSaved = { [weak account] folder, id in account?.queueEpisode(folder, id: id, owner: owner) }
            guard let owner, let directory = try? account.queue.recordingDirectory(origin: owner.origin, installationID: owner.installationID) else { return }
            do { try camera.configure(directory: directory) }
            catch { return }
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

private struct DeveloperSensorOverlay: View {
    @ObservedObject var camera: EpisodeCameraController
    var compact = false
    private func values(_ stream: String) -> String {
        guard let sample = camera.latestMotion[stream] else { return "—" }
        return sample.values.map { String(format: "%.2f", $0) }.joined(separator: ", ")
    }
    var body: some View {
        let pose = camera.latestPose
        let matrix = pose?.cameraToWorldColumns ?? []
        let position = matrix.count == 16 ? [matrix[12], matrix[13], matrix[14]].map { String(format: "%.2f", $0) }.joined(separator: ", ") : "—"
        let rotation = pose?.cameraOrientationQuaternion.map { String(format: "%.2f", $0) }.joined(separator: ", ") ?? "—"
        VStack(alignment: .leading, spacing: compact ? 1 : 3) {
            Text("DEV SENSORS").fontWeight(.bold)
            Text("Accel g: \(values("accelerometer"))")
            Text("Gyro rad/s: \(values("gyroscope"))")
            Text("Attitude xyzw: \(values("attitude"))")
            Text("Position m: \(position)")
            Text("Camera xyzw: \(rotation)")
            Text("Frame time: \(pose.map { String(format: "%.3f", $0.timestamp) } ?? "—")")
            Text("IMU time: \(camera.latestMotion["accelerometer"].map { String(format: "%.3f", $0.timestamp) } ?? "—")")
            Text("Frame/callback Δ: \(pose.map { String(format: "%.3f s", $0.callbackUptime - $0.timestamp) } ?? "—")")
            Text("Tracking: \(pose?.tracking ?? "—") \(pose?.trackingReason ?? "")")
            Text("\(camera.status) · \(camera.pendingEpisodes) pending")
        }
        .font(.system(size: compact ? 9 : 10, design: .monospaced))
        .padding(compact ? 6 : 8)
        .background(.black.opacity(0.72), in: RoundedRectangle(cornerRadius: 8))
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("developerSensorOverlay")
    }
}

#Preview {
    ContentView().environmentObject(AccountSession(configuration: nil))
}
