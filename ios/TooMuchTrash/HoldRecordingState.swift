/// Accessed only on the capture queue. A release can precede the didStart callback.
struct HoldRecordingState {
    enum Phase { case idle, starting, recording, finishing }
    enum Action { case none, start, stop }
    private(set) var phase: Phase = .idle
    private var heldSources: Set<String> = []

    mutating func press(_ source: String) -> Action {
        guard phase != .finishing else { return .none }
        heldSources.insert(source)
        guard phase == .idle else { return .none }
        phase = .starting
        return .start
    }

    mutating func release(_ source: String) -> Action {
        heldSources.remove(source)
        guard heldSources.isEmpty, phase == .recording else { return .none }
        phase = .finishing
        return .stop
    }

    mutating func didStart() -> Action {
        if heldSources.isEmpty {
            phase = .finishing
            return .stop
        }
        phase = .recording
        return .none
    }

    mutating func cancel() -> Action {
        heldSources.removeAll()
        guard phase == .recording else { return .none }
        phase = .finishing
        return .stop
    }

    mutating func didFinish() {
        phase = .idle
        heldSources.removeAll()
    }
}
