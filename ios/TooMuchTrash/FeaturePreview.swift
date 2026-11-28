#if DEBUG
import SwiftUI
import CoreLocation

/// Isolated Simulator UI review, with no account, network or location access.
struct FeaturePreview: View {
    static var requested: Bool {
        #if targetEnvironment(simulator)
        return ProcessInfo.processInfo.arguments.contains("-recording-dashboard-preview") || ProcessInfo.processInfo.arguments.contains("-full-recording-preview") || ProcessInfo.processInfo.arguments.contains("-camera-settings-preview") || ProcessInfo.processInfo.arguments.contains("-cleanup-session-preview")
        #else
        return false
        #endif
    }
    @StateObject private var settings = CameraViewSettings(defaults: UserDefaults(suiteName: "feature-preview-" + UUID().uuidString)!)
    @StateObject private var cleanup = CleanupSessionStore(locationEnabled: false, placeLookup: { _ in "Sunset District, San Francisco, CA" })
    @StateObject private var previewCamera = EpisodeCameraController()
    @StateObject private var previewAccount = AccountSession(configuration: nil, queue: CaptureQueue(directory: FileManager.default.temporaryDirectory.appendingPathComponent("dashboard-preview-" + UUID().uuidString)))
    @State private var recording = false
    @State private var showStart = false
    var body: some View {
        Group {
            if ProcessInfo.processInfo.arguments.contains("-recording-dashboard-preview") {
                ContentView(camera: previewCamera).environmentObject(previewAccount)
                    .task {
                        #if targetEnvironment(simulator)
                        previewCamera.debugSetFullRecordingForPreview()
                        #endif
                    }
            }
            else if ProcessInfo.processInfo.arguments.contains("-full-recording-preview") {
                VStack {
                    FullSessionRecordingControl(active: recording, changing: false, ready: true) {
                        if cleanup.activeID == nil { showStart = true } else { recording = true }
                    } stop: { recording = false }
                    Text(cleanup.activeID == nil ? "No cleanup walk" : "Cleanup walk active")
                }.modifier(FullRecordingStartFlow(store: cleanup, presented: $showStart) { recording = true })
            }
            else if ProcessInfo.processInfo.arguments.contains("-camera-settings-preview") { CameraSettingsView(settings: settings) }
            else { CleanupSessionView(store: cleanup) }
        }.task {
            let directory = FileManager.default.temporaryDirectory.appendingPathComponent("cleanup-preview-" + UUID().uuidString)
            try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
            try? cleanup.bind(directory: directory)
            if ProcessInfo.processInfo.arguments.contains("-cleanup-preview-empty") || ProcessInfo.processInfo.arguments.contains("-full-recording-preview") { return }
            try? cleanup.start()
            if let id = cleanup.activeID { try? cleanup.edit(id: id, name: "Beach cleanup", description: "Morning shoreline cleanup") }
            if ProcessInfo.processInfo.arguments.contains("-cleanup-preview-place") {
                cleanup.markLocation()
                cleanup.accept([CLLocation(coordinate: .init(latitude: 37.75, longitude: -122.49), altitude: 0, horizontalAccuracy: 5, verticalAccuracy: 5, timestamp: Date().addingTimeInterval(0.01))])
            }
        }
    }
}
#endif
