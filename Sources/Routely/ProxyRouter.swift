//
// Copyright © 2025 Движ
//

import Foundation
import Observation
import RoutelyInterfaces

@Observable
final class ProxyRouter<Route: ProxyRouteDestinationProtocol>: Router<Route> {
    let wrapped = Router<Route.Base>()

    override var id: UUID {
        wrapped.id
    }

    override var state: RouterState<Route> {
        get { .init(wrapped.state) }
        set { wrapped.state = newValue.toBase() }
    }
}
