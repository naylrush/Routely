//
// Copyright © 2025 Движ
//

import Foundation
import Observation
import RoutelyInterfaces

final class ProxyEnhancedRouter<Route: ConvertibleRoutableDestination>: EnhancedRouter<Route> {
    let wrapped = EnhancedRouter<Route.Target>()

    override var id: UUID {
        wrapped.id
    }

    override var state: EnhancedRouterState<Route> {
        get { .init(wrapped.state) }
        set { wrapped.state = newValue.into() }
    }
}
