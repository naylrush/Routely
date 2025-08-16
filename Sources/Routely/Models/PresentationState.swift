//
// Copyright © 2025 Движ
//

import Foundation
import RoutelyInterfaces

struct PresentationState<Route: RouteProtocol>: Equatable, Sendable {
    let style: PresentationStyle
    let routeWithResult: RouteWithResult<Route>
}
