//
// Copyright © 2025 Движ
//

import Foundation

struct PresentationState<Route: Routable>: Equatable, Sendable {
    let style: PresentationStyle
    let routeWithResult: RouteWithResult<Route>
}
