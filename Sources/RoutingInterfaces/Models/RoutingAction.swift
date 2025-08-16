//
// Copyright © 2025 Движ
//

import OSLog
import SwiftUI

public struct RoutingAction<T>: Sendable {
    public typealias Action = @MainActor (T) -> Void

    private let id = UUID()
    public let isDummy: Bool

    private let action: Action

    public init(action: @escaping Action) {
        self.isDummy = false
        self.action = action
    }

    private init() {
        self.isDummy = true
        self.action = { _ in
            logger.error("Dummy routing action is called")
        }
    }

    @MainActor
    public func callAsFunction(_ value: T) {
        logger.debug("Did call routing action")
        action(value)
    }
}

extension RoutingAction<Void> {
    @MainActor
    public func callAsFunction() {
        callAsFunction(())
    }
}

extension RoutingAction: Equatable {
    public static func == (lhs: RoutingAction<T>, rhs: RoutingAction<T>) -> Bool {
        (lhs.isDummy && lhs.isDummy == rhs.isDummy) || lhs.id == rhs.id
    }
}

extension RoutingAction {
    public static func createDummy() -> RoutingAction {
        .init()
    }
}

extension RoutingAction<Void> {
    public static let dummy = createDummy()
}

private let logger = Logger(subsystem: "Routing", category: "RoutingAction")
