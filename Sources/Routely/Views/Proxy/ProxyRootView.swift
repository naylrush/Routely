//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
import SwiftUI

struct ProxyRootView<Route: ProxyRouteDestinationProtocol, Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        ProxyEnhancedRouterHolderView<Route, _> { router in
            RootContentView(router: router) {
                content
            }
        }
    }
}

extension ProxyRootView where Content == Route.Destination {
    init(initialRoute: Route) {
        self.init {
            initialRoute.destination
        }
    }
}
