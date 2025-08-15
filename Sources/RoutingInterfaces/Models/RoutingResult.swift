//
// Copyright © 2025 Движ
//

import Foundation
import OSLog

public final class RoutingResult: Sendable {
    public typealias Value = (any Sendable)
    public typealias Completion<T> = @Sendable @MainActor (T?) -> Void

    public let id = UUID()
    private let isDummy: Bool

    @MainActor public var value: Value? {
        didSet {
            if isDummy {
                logger.warning("Setting value to dummy RoutingResult")
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
            logger.warning("Calling completion dummy RoutingResult")
        }
    }

    @MainActor
    public func complete() {
        completion(value)
    }
}

extension RoutingResult {
    static let dummy = RoutingResult()
}

extension RoutingResult: Equatable {
    public static func == (lhs: RoutingResult, rhs: RoutingResult) -> Bool {
        (lhs.isDummy && lhs.isDummy == rhs.isDummy) || lhs.id == rhs.id
    }
}

private let logger = Logger(subsystem: "Routing", category: "RoutingResult")
