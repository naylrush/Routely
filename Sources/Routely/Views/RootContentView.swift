//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
import SwiftUI

struct RootContentView<Route: ProxyRouteDestinationProtocol, Content: View>: View {
    let router: EnhancedRouter<Route>
    @ViewBuilder let content: Content

    var body: some View {
        RouterConfigurationView(router: router) {
            OpenURLOverridingView(router: router) {
                PresentingView(router: router) {
                    StackView(router: router) {
                        DeepLinkingView(router: router) {
                            content
                        }
                    }
                }
            }
        }
    }
}
