import Foundation

/// Unlike a task-group timeout, this also returns when a child ignores
/// cancellation (for example a background URLSession daemon callback).
@MainActor enum OperationDeadline {
    static func run<T>(seconds: TimeInterval, operation: @escaping @MainActor () async throws -> T) async throws -> T {
        try Task.checkCancellation()
        return try await Race<T>().run(seconds: seconds, operation: operation)
    }
    @MainActor private final class Race<T> {
        private var continuation: CheckedContinuation<T, Error>?
        private var operationTask: Task<Void, Never>?
        private var timerTask: Task<Void, Never>?
        func run(seconds: TimeInterval, operation: @escaping @MainActor () async throws -> T) async throws -> T {
            try await withTaskCancellationHandler {
                try await withCheckedThrowingContinuation { continuation in
                    self.continuation = continuation
                    operationTask = Task {
                        do { self.finish(.success(try await operation())) }
                        catch { self.finish(.failure(error)) }
                    }
                    timerTask = Task {
                        do { try await Task.sleep(for: .seconds(seconds)); self.finish(.failure(URLError(.timedOut))) }
                        catch { }
                    }
                }
            } onCancel: { Task { @MainActor in self.finish(.failure(CancellationError())) } }
        }
        private func finish(_ result: Result<T, Error>) {
            guard let continuation else { return }
            self.continuation = nil
            let op = operationTask, timer = timerTask
            operationTask = nil; timerTask = nil
            op?.cancel(); timer?.cancel()
            continuation.resume(with: result)
        }
    }
}
