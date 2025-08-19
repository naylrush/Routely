//
// Copyright © 2025 Движ
//

import Foundation
import Observation
import RoutelyInterfaces

final class CompositeConvertibleRouter<
    ConvertibleRoute: ConvertibleRoutableDestination
>: CompositeRouter<ConvertibleRoute> {
    let wrapped = CompositeRouter<ConvertibleRoute.Target>()

    override var id: UUID {
        wrapped.id
    }

    override var state: CompositeRouterState<ConvertibleRoute> {
        get { .init(wrapped.state) }
        set { wrapped.state = newValue.into() }
    }
}
