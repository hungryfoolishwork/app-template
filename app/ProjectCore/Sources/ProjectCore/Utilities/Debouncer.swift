import Foundation

/// A utility for debouncing async operations.
///
/// Debouncing ensures that a function is only executed after a specified delay has passed
/// since the last invocation. If the function is called again before the delay completes,
/// the previous call is cancelled and the timer resets.
///
/// Example usage:
/// ```swift
/// let debouncer = Debouncer(delay: .seconds(1))
///
/// // Each call cancels the previous one
/// debouncer.run {
///     try await saveFile()
/// }
/// ```
@MainActor
public final class Debouncer {
    private var task: Task<Void, Never>?
    private let delay: Duration

    /// Creates a new debouncer with the specified delay.
    /// - Parameter delay: The duration to wait before executing the action.
    public init(delay: Duration = .milliseconds(500)) {
        self.delay = delay
    }

    /// Schedules an async action to run after the debounce delay.
    ///
    /// If called again before the delay completes, the previous action is cancelled
    /// and the timer resets.
    ///
    /// - Parameters:
    ///   - action: The async throwing action to execute after the delay.
    ///   - onError: Optional error handler. If not provided, errors are silently ignored.
    public func run(
        onError: (@MainActor (Error) -> Void)? = nil,
        action: @escaping @MainActor () async throws -> Void
    ) {
        task?.cancel()
        task = Task {
            do {
                try await Task.sleep(for: delay)
                try await action()
            } catch is CancellationError {
                // Expected when debounce is triggered again
            } catch {
                onError?(error)
            }
        }
    }

    /// Cancels any pending debounced action.
    public func cancel() {
        task?.cancel()
        task = nil
    }
}
