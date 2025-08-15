//
// Copyright © 2025 Движ
//

import SwiftUI

extension EnvironmentValues {
    @Entry public var dvijDismiss: RoutingAction<Void> = .dummy

    @Entry public var finishWholeRoute: RoutingAction<Void> = .dummy

    @Entry public var finishCurrentRoute: RoutingAction<Void> = .dummy

    @Entry public var next: RoutingAction<Void> = .dummy

    @Entry public var routingResult: RoutingResult = .dummy

    @Entry public var isTopHierarchy = false

    @Entry public var isLastInStack = false
}
