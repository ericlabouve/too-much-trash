import Foundation

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

/// Plans independent episode windows on a caller-supplied monotonic clock.
/// This only schedules boundaries; it does not capture or persist sensor data.
struct EpisodeWindowScheduler {
    struct Window: Equatable {
        let id: UUID
        let source: String
        let pressedAt: TimeInterval
        let start: TimeInterval
        var releasedAt: TimeInterval?
        var end: TimeInterval?
        var incompleteReason: String?
    }

    private(set) var pending: [Window] = []
    private let padding: TimeInterval

    init(padding: TimeInterval = 3) {
        precondition(padding >= 0 && padding.isFinite)
        self.padding = padding
    }

    mutating func press(_ source: String, at time: TimeInterval) -> Window? {
        guard time.isFinite, !pending.contains(where: { $0.source == source && $0.end == nil }) else { return nil }
        let window = Window(id: UUID(), source: source, pressedAt: time, start: time - padding)
        pending.append(window)
        return window
    }

    mutating func release(_ source: String, at time: TimeInterval) {
        guard time.isFinite, let index = pending.firstIndex(where: { $0.source == source && $0.end == nil }),
              time >= pending[index].pressedAt else { return }
        pending[index].releasedAt = time
        pending[index].end = time + padding
    }

    mutating func cancel(_ source: String, at time: TimeInterval, reason: String) {
        guard time.isFinite, let index = pending.firstIndex(where: { $0.source == source && $0.end == nil }),
              time >= pending[index].pressedAt else { return }
        pending[index].end = time
        pending[index].incompleteReason = reason
    }

    mutating func completed(through time: TimeInterval) -> [Window] {
        guard time.isFinite else { return [] }
        let ready = pending.filter { $0.end.map { $0 <= time } ?? false }
        pending.removeAll { $0.end.map { $0 <= time } ?? false }
        return ready
    }

    mutating func take(_ id: UUID) -> Window? {
        guard let index = pending.firstIndex(where: { $0.id == id }) else { return nil }
        return pending.remove(at: index)
    }

    mutating func interrupt(at time: TimeInterval, reason: String) -> [Window] {
        guard time.isFinite else { return [] }
        let interrupted = pending.map { window in
            var result = window
            if window.end.map({ $0 > time }) ?? true {
                result.end = time
                result.incompleteReason = reason
            }
            return result
        }
        pending.removeAll()
        return interrupted
    }
}

/// A bounded pre-roll for one independently sampled sensor stream. Callers
/// must persist live samples for open episodes separately from this buffer.
struct TimedPreRoll<Value> {
    struct Sample {
        let time: TimeInterval
        let value: Value
    }

    private(set) var samples: [Sample] = []
    private(set) var outOfOrderCount = 0
    private(set) var rejectedLateCount = 0
    let duration: TimeInterval

    init(duration: TimeInterval = 3) {
        precondition(duration >= 3 && duration.isFinite)
        self.duration = duration
    }

    @discardableResult
    mutating func append(time: TimeInterval, value: Value) -> Bool {
        guard time.isFinite else {
            rejectedLateCount += 1
            return false
        }
        let latest = samples.last?.time ?? time
        if time < latest {
            outOfOrderCount += 1
            guard time >= latest - duration else { rejectedLateCount += 1; return false }
            let index = samples.firstIndex { $0.time > time } ?? samples.endIndex
            samples.insert(Sample(time: time, value: value), at: index)
        } else {
            samples.append(Sample(time: time, value: value))
        }
        // Retain the boundary sample at exactly the requested start.
        let cutoff = max(time, latest) - duration
        if let first = samples.firstIndex(where: { $0.time >= cutoff }), first > 0 {
            samples.removeFirst(first)
        }
        return true
    }

    func snapshot(from start: TimeInterval, through end: TimeInterval) -> [Sample] {
        guard start.isFinite, end.isFinite, start <= end else { return [] }
        return samples.filter { $0.time >= start && $0.time <= end }
    }
}

/// Pure retention decisions for completed encoded segments; file deletion and
/// active writers remain the caller's responsibility.
struct EpisodeSegmentIndex {
    struct Segment: Equatable {
        let id: UUID
        let start: TimeInterval
        let end: TimeInterval
    }

    private(set) var segments: [Segment] = []

    mutating func add(_ segment: Segment) -> Bool {
        guard segment.start.isFinite, segment.end.isFinite, segment.start <= segment.end,
              !segments.contains(where: { $0.id == segment.id }) else { return false }
        segments.append(segment)
        segments.sort { $0.start < $1.start }
        return true
    }

    func overlapping(start: TimeInterval, end: TimeInterval) -> [Segment] {
        guard start.isFinite, end.isFinite, start <= end else { return [] }
        return segments.filter { $0.end >= start && $0.start <= end }
    }

    func disposable(now: TimeInterval, preRoll: TimeInterval = 3,
                    pending: [EpisodeWindowScheduler.Window]) -> [Segment] {
        guard now.isFinite, preRoll.isFinite, preRoll >= 3 else { return [] }
        return segments.filter { segment in
            guard segment.end < now - preRoll else { return false }
            return !pending.contains { window in
                segment.end >= window.start && segment.start <= (window.end ?? .infinity)
            }
        }
    }

    mutating func remove(_ id: UUID) { segments.removeAll { $0.id == id } }
}
