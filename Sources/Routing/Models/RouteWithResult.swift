//
// Copyright © 2025 Движ
//

import Foundation
import RoutingInterfaces

struct RouteWithResult<Route: RouteProtocol>: Equatable, Sendable {
    let route: Route
    let result: RoutingResult?
}
