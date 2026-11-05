import SwiftUI
import ARKit

struct TimingReferenceView: View {
    @ObservedObject var account: AccountSession
    @StateObject private var camera = EpisodeCameraController()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.scenePhase) private var phase
    @State private var started: Date?
    @State private var collecting = false
    @State private var awaitingExport = false
    @State private var message = "No timing correction has been measured or applied."
    @State private var collectionTask: Task<Void, Never>?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Collect a timing reference").font(.title2.bold())
                    Text("Mount the phone as you use it in the field. Face a well-lit, stationary textured wall or printed target. Stay in place and gently rotate the grabber; avoid walking, moving objects and blur.")
                    Text("This saves a 20-second reference recording for later analysis. It does not calibrate the phone or apply a guessed offset.")
                        .foregroundStyle(.secondary)
                    ReferencePreview(camera: camera)
                        .frame(height: 180).clipShape(RoundedRectangle(cornerRadius: 14))
                    if let started, collecting {
                        TimelineView(.periodic(from: .now, by: 0.2)) { context in
                            Text(TimingReference.instruction(elapsed: context.date.timeIntervalSince(started)))
                                .font(.headline)
                        }
                    }
                    Text("Tracking: \(camera.latestPose?.tracking ?? "unavailable")")
                    Text(camera.status).font(.caption)
                    Text(message).accessibilityIdentifier("timingReferenceStatus")
                    Button(collecting ? "Collecting…" : awaitingExport ? "Saving reference…" : "Collect reference") { begin() }
                        .buttonStyle(.borderedProminent)
                        .disabled(!camera.isReady || collecting || awaitingExport || camera.latestPose?.tracking != "normal")
                        .accessibilityIdentifier("collectTimingReference")
                    Text("For button delay, a separate slow-motion camera must see the harness lever and recording indicator together. Repeat presses and releases. That measures lever-to-display delay, including mechanical and display delays; these sensor streams cannot reveal the hidden switch's exact electrical edge.")
                        .font(.footnote).foregroundStyle(.secondary)
                }.padding(20)
            }
            .navigationTitle("Timing reference").navigationBarTitleDisplayMode(.inline)
            .toolbar { ToolbarItem(placement: .topBarTrailing) {
                Button(collecting || awaitingExport ? "Stop & Close" : "Done") {
                    collectionTask?.cancel()
                    camera.deactivate()
                    dismiss()
                }
            } }
            .interactiveDismissDisabled(collecting || awaitingExport)
            .task { await configure() }
            .onChange(of: phase) { _, value in
                if value == .active { Task { await camera.activate() } }
                else {
                    collectionTask?.cancel()
                    collecting = false
                    camera.deactivate()
                    message = "Collection interrupted. Available raw data is retained; collect another reference."
                }
            }
            .onDisappear { collectionTask?.cancel(); camera.deactivate() }
        }
    }

    private func configure() async {
        let owner = account.captureOwner
        camera.onEpisodeSaved = { folder, id in
            do {
                try TimingReference.annotateEpisode(at: folder, episodeID: id,
                    deviceModel: TimingReference.hardwareModel, osVersion: UIDevice.current.systemVersion)
                account.queueEpisode(folder, id: id, owner: owner)
                message = "Reference saved for upload. Timing remains unverified until independent analysis is complete."
            } catch {
                message = "Reference metadata could not be saved. Raw files are retained on this phone."
            }
            awaitingExport = false
        }
        guard let owner else { return }
        do {
            let folder = try account.queue.recordingDirectory(origin: owner.origin, installationID: owner.installationID)
            try camera.configure(directory: folder)
            await camera.activate()
        } catch { message = "Private storage needs attention before collecting a reference." }
    }

    private func begin() {
        guard camera.isReady, !collecting, !awaitingExport else { return }
        started = Date()
        collecting = true
        awaitingExport = true
        message = "Recording raw video and motion. Follow the movement instructions."
        camera.press("screen")
        collectionTask = Task { @MainActor in
            do { try await Task.sleep(for: .seconds(TimingReference.holdDuration)) }
            catch { return }
            camera.release("screen")
            collecting = false
            message = "Hold still while the final three seconds are recorded and saved."
        }
    }
}

/// Reference collection uses an automatic timed hold, without hardware handlers.
private struct ReferencePreview: UIViewRepresentable {
    @ObservedObject var camera: EpisodeCameraController
    func makeUIView(context: Context) -> ARSCNView {
        let view = ARSCNView()
        if let session = camera.session { view.session = session }
        return view
    }
    func updateUIView(_ view: ARSCNView, context: Context) {
        if let session = camera.session, view.session !== session { view.session = session }
    }
}
