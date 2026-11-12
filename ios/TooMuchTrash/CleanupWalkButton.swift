import HealthKit
import SwiftUI

struct CleanupWalkButton: View {
    @State private var busy = false
    @State private var message = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Button {
                busy = true
                Task { @MainActor in
                    defer { busy = false }
                    guard HKHealthStore.isHealthDataAvailable() else {
                        message = "HealthKit is unavailable on this device."; return
                    }
                    let configuration = HKWorkoutConfiguration()
                    configuration.activityType = .walking
                    configuration.locationType = .outdoor
                    do {
                        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
                            HKHealthStore().startWatchApp(with: configuration) { success, error in
                                if let error { continuation.resume(throwing: error) }
                                else if success { continuation.resume() }
                                else { continuation.resume(throwing: NSError(domain: "CleanupWalk", code: 1,
                                    userInfo: [NSLocalizedDescriptionKey: "The Watch app could not be opened."])) }
                            }
                        }
                        message = "Continue on your Watch. End the cleanup walk there when finished."
                    } catch { message = "Could not open Watch workout: \(error.localizedDescription)" }
                }
            } label: { Label("Start cleanup walk on Watch", systemImage: "figure.walk") }
                .disabled(busy)
            Text(message.isEmpty ? "Starts an outdoor walking workout. Your Watch will ask for Health permission. End the walk on your Watch." : message)
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}
