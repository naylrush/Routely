//
// Copyright © 2025 Движ
//

import OSLog
import SwiftUI

public struct RoutelyAction<T>: Sendable {
    public typealias Action = @MainActor (T) -> Void

    private let id = UUID()
    private let label: String

    public let isDummy: Bool

    private let action: Action

    public init(
        _ label: String = "",
        action: @escaping Action
    ) {
        self.label = label
        self.isDummy = false
        self.action = action
    }

    private init() {
        self.label = ""
        self.isDummy = true
        self.action = { [label, id] _ in
            logger.error("[\(id)][\(label)] Dummy routing action is called")
        }
    }

    @MainActor
    public func callAsFunction(_ value: T, shouldLog: Bool = true) {
        if shouldLog {
            logger.debug("[\(self.id)][\(self.label)] Did call routing action with value: \(String(describing: value))")
        }
        action(value)
    }
}

extension RoutelyAction<Void> {
    @MainActor
    public func callAsFunction(shouldLog: Bool = true) {
        callAsFunction((), shouldLog: shouldLog)
    }
}

extension RoutelyAction: Equatable {
    public static func == (lhs: RoutelyAction<T>, rhs: RoutelyAction<T>) -> Bool {
        (lhs.isDummy && lhs.isDummy == rhs.isDummy) || lhs.id == rhs.id
    }
}

extension RoutelyAction {
    public static func createDummy() -> RoutelyAction {
        .init()
    }
}

extension RoutelyAction<Void> {
    public static let dummy = createDummy()
}

public typealias FinishWholeRouteAction = RoutelyAction<any Sendable>

extension FinishWholeRouteAction {
    public static let dummy = createDummy()
}

private let logger = Logger(subsystem: "Routely", category: "RoutelyAction")
