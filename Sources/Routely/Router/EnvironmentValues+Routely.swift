//
// Copyright © 2025 Движ
//

import SwiftUI

extension EnvironmentValues {
    @Entry public var dvijDismiss: RoutelyAction<Void> = .dummy

    @Entry public var finishWholeRoute: FinishWholeRouteAction = .dummy

    @Entry public var finishCurrentRoute: RoutelyAction<Void> = .dummy

    @Entry public var next: RoutelyAction<Void> = .dummy

    @Entry public var routingResult: RoutelyResult = .dummy

    @Entry public var isTopHierarchy = false

    @Entry public var isLastInStack = false
}
