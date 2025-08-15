//
// Copyright © 2025 Движ
//

import Foundation
import RoutingInterfaces

struct PresentationState<Route: RouteProtocol>: Sendable {
    let style: PresentationStyle
    let routeWithResult: RouteWithResult<Route>
}
