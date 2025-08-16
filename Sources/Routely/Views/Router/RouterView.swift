//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
import SwiftUI

struct RouterView<ProxyRoute: ProxyRouteDestinationProtocol, Content: View>: View {
    @Environment(Router<ProxyRoute.Base>.self)
    private var externalRouter: Router?

    @State private var proxyRouter = ProxyRouter<ProxyRoute>()
    @ViewBuilder let content: (Router<ProxyRoute>) -> Content

    var body: some View {
        let router = proxyRouter.wrapped

        RouterConfigurationView(
            router: router,
            externalRouter: externalRouter
        ) {
            HierarchyConfigurationView(
                router: router,
                externalRouter: externalRouter
            ) {
                RoutelyActionsConfigurationView(router: router) {
                    content(proxyRouter)
                }
            }
        }
        .environment(router)
    }
}
