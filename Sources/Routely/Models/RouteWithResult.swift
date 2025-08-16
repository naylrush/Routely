//
// Copyright © 2025 Движ
//

import Foundation
import RoutelyInterfaces

struct RouteWithResult<Route: RouteProtocol>: Equatable, Sendable {
    let route: Route
    let result: RoutelyResult?
}
