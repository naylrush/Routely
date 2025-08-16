//
// Copyright © 2025 Движ
//

import Foundation
import OSLog

public final class RoutelyResult: Sendable {
    public typealias Value = (any Sendable)
    public typealias Completion<T> = @Sendable @MainActor (T?) -> Void

    public let id = UUID()
    private let isDummy: Bool

    @MainActor public var value: Value? {
        didSet {
            if isDummy {
                logger.warning("Setting value to dummy RoutelyResult")
            } else {
                logger.debug("[\(self.id)] Did set value: \(self.value.debugDescription)")
            }
        }
    }

    private let completion: Completion<Value>

    public init<T>(completion: @escaping Completion<T>) {
        self.isDummy = false
        self.completion = { [logger] anyValue in
            let value: T? = {
                switch anyValue {
                case let value as T?:
                    return value

                default:
                    logger.error("Type mismatch for routing completion, expected \(T.self)")
                    return nil
                }
            }()

            Task { @MainActor in
                completion(value)
            }
        }
    }

    private init() {
        self.isDummy = true
        self.completion = { _ in
            logger.warning("Calling completion dummy RoutelyResult")
        }
    }

    @MainActor
    public func complete() {
        completion(value)
    }
}

extension RoutelyResult {
    static let dummy = RoutelyResult()
}

extension RoutelyResult: Equatable {
    public static func == (lhs: RoutelyResult, rhs: RoutelyResult) -> Bool {
        (lhs.isDummy && lhs.isDummy == rhs.isDummy) || lhs.id == rhs.id
    }
}

private let logger = Logger(subsystem: "Routely", category: "RoutelyResult")
