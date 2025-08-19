//
// Copyright © 2025 Движ
//

import Foundation
import RoutelyInterfaces

struct PresentationState<Route: Routable>: Equatable, Sendable {
    let style: PresentationStyle
    let routeWithResult: RouteWithResult<Route>
}
