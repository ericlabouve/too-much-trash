import HealthKit
import WatchKit
import SwiftUI

/// A user-started outdoor cleanup walk. Health data stays in HealthKit.
@MainActor
final class CleanupWorkout: NSObject, ObservableObject, HKWorkoutSessionDelegate {
    @Published private(set) var active = false
    @Published private(set) var busy = false
    @Published private(set) var message = ""
    private let store = HKHealthStore()
    private var session: HKWorkoutSession?
    private var builder: HKLiveWorkoutBuilder?

    func start(configuration: HKWorkoutConfiguration? = nil) async {
        guard session == nil, !busy else { return }
        guard HKHealthStore.isHealthDataAvailable() else { message = "Workouts are unavailable on this Watch."; return }
        busy = true
        defer { busy = false }
        do {
            try await store.requestAuthorization(toShare: [HKObjectType.workoutType()], read: [])
            try Task.checkCancellation()
            guard store.authorizationStatus(for: HKObjectType.workoutType()) == .sharingAuthorized else {
                message = "Allow saving workouts in Health permissions to start a cleanup walk."
                return
            }
            let config = configuration ?? HKWorkoutConfiguration()
            config.activityType = .walking
            config.locationType = .outdoor
            let workout = try HKWorkoutSession(healthStore: store, configuration: config)
            workout.delegate = self
            let live = workout.associatedWorkoutBuilder()
            // Save duration and workout type only; no health metrics are sent to our backend.
            session = workout
            builder = live
            let start = Date()
            workout.startActivity(with: start)
            try await live.beginCollection(at: start)
            active = true
            message = "Cleanup walk active"
        } catch {
            session?.end()
            builder?.discardWorkout()
            session = nil
            builder = nil
            active = false
            message = "Could not start cleanup walk: \(error.localizedDescription)"
        }
    }

    func end() {
        guard let session, !busy else { return }
        busy = true
        session.end()
    }

    nonisolated func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState,
                                    from fromState: HKWorkoutSessionState, date: Date) {
        guard toState == .ended else { return }
        Task { @MainActor in
            guard self.session === workoutSession else { return }
            self.active = false
            self.busy = true
            do {
                if let builder = self.builder {
                    try await builder.endCollection(at: date)
                    _ = try await builder.finishWorkout()
                }
                self.message = "Cleanup walk saved to Health."
            } catch { self.message = "Walk ended, but could not save: \(error.localizedDescription)" }
            self.session = nil
            self.builder = nil
            self.busy = false
        }
    }

    nonisolated func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        Task { @MainActor in
            guard self.session === workoutSession else { return }
            self.builder?.discardWorkout()
            self.session = nil
            self.builder = nil
            self.active = false
            self.busy = false
            self.message = "Cleanup walk stopped: \(error.localizedDescription)"
        }
    }
}

final class CleanupAppDelegate: NSObject, WKApplicationDelegate {
    func handle(_ workoutConfiguration: HKWorkoutConfiguration) {
        Task { @MainActor in await Self.workout.start(configuration: workoutConfiguration) }
    }
    @MainActor static let workout = CleanupWorkout()
}
