//
// Copyright © 2025 Движ
//

import Factory

extension Container {
    var routingManager: Factory<RoutingManager> {
        self { @MainActor in RoutingManager() }
            .scope(.singleton)
    }
}
