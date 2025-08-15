//
// Copyright © 2025 Движ
//
import OSLog

extension Logger {
    public func loggingError(_ body: @Sendable () async throws -> Void) async {
        do {
            try await body()
        } catch {
            self.error("\(error)")
        }
    }

    public func rethrowingError<T>(_ body: @Sendable () async throws -> T) async rethrows -> T {
        do {
            return try await body()
        } catch {
            self.error("\(error)")
            throw error
        }
    }
}
