//
// Copyright © 2025 Движ
//

import Foundation
import Observation
import OSLog

final class ConvertibleRouter<ConvertibleRoute: ConvertibleRoutable>: Router<ConvertibleRoute> {
    let wrapped = Router<ConvertibleRoute.Target>(shouldLogInit: false)

    override var id: UUID {
        wrapped.id
    }

    override var state: RouterState<ConvertibleRoute> {
        get { .init(wrapped.state) }
        set { wrapped.state = newValue.into() }
    }
}

private let logger = Logger(subsystem: "Routely", category: "CompositeRouter")
