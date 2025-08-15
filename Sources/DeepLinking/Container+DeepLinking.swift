//
// Copyright © 2025 Движ
//

import Factory

extension Container {
    public var deepLinkRegistry: Factory<Registry> {
        self { Registry() }
            .scope(.singleton)
    }

    public var deepLinkingManager: Factory<DeepLinkingManager> {
        self { @MainActor in DeepLinkingManager() }
            .scope(.singleton)
    }
}
