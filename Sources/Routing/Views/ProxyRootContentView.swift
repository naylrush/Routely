//
// Copyright © 2025 Движ
//

import RoutingInterfaces
import SwiftUI

struct ProxyRootContentView<Route: ProxyRouteDestinationProtocol, Content: View>: View {
    let router: Router<Route>
    @ViewBuilder let content: Content

    var body: some View {
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
