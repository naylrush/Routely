//
// Copyright © 2025 Движ
//

import Observation
import RoutelyInterfaces

@Observable
final class ProxyRouter<Route: ProxyRouteDestinationProtocol>: Router<Route> {
    let wrapped = Router<Route.Base>()

    override var state: RouterState<Route> {
        get { .init(wrapped.state) }
        set { wrapped.state = newValue.toBase() }
    }
}
