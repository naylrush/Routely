//
// Copyright © 2025 Движ
//

import Foundation
import OSLog

public final class RoutelyResult: Sendable, Identifiable {
    public typealias Value = (any Sendable)
    public typealias Params = [String: Value]
    public typealias Completion<T> = @Sendable @MainActor (T?, Params?) -> Void

    public let id = UUID()
    public let isDummy: Bool

    @MainActor public var value: Value? {
        didSet {
            if isDummy {
                logger.warning("Setting result to dummy RoutelyResult")
            } else {
                logger.debug("[\(self.id)] Did set result: \(self.value.map { String(describing: $0) } ?? "nil")")
            }
        }
    }

    @MainActor public private(set) var params: Params?

    private let completion: Completion<Value>

    public init<T>(completion: @escaping Completion<T>) {
        self.isDummy = false
        self.completion = { [logger] anyValue, params in
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
                completion(value, params)
            }
        }
    }

    private init() {
        self.isDummy = true
        self.completion = { [id] _, _ in
            logger.warning("[\(id)] Calling completion dummy RoutelyResult")
        }
    }

    @MainActor
    public func complete() {
        logger.debug(
            // swiftlint:disable:next line_length
            "[\(self.id)] Completing with result: \(self.value.map { String(describing: $0) } ?? "nil"), params: \(self.params.map { String(describing: $0) } ?? "nil")"
        )
        completion(value, params)
    }

    @MainActor
    public subscript(_ key: String) -> Value? {
        get {
            params?[key]
        }
        set {
            if params == nil {
                params = [:]
            }
            params?[key] = newValue
        }
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
