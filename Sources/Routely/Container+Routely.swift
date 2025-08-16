//
// Copyright © 2025 Движ
//

import Factory

extension Container {
    var routingManager: Factory<RoutelyManager> {
        self { @MainActor in RoutelyManager() }
            .scope(.singleton)
    }
}
