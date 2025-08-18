//
// Copyright © 2025 Движ
//

import DeepLinking
import RoutelyInterfaces
import SwiftUI

struct ProxyRootView<Route: ProxyRouteDestinationProtocol, Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        RouterConfigurationView<Route, _> { router in
            OpenURLOverridingView(router: router) {
                PresentingView(router: router) {
                    StackView(router: router) {
                        if DeepLinking.Configuration.isEnabled {
                            DeepLinkingView(router: router) {
                                content
                            }
                        } else {
                            content
                        }
                    }
                }
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
