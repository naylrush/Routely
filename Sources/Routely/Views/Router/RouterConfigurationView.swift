//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
import SwiftUI

struct RouterConfigurationView<Route: ConvertibleRoutableDestination, Content: View>: View {
    @Environment(EnhancedRouter<Route.Target>.self)
    private var externalRouter: EnhancedRouter?

    @State private var proxyRouter = ProxyEnhancedRouter<Route>()

    @ViewBuilder let content: (ProxyEnhancedRouter<Route>) -> Content

    var body: some View {
        let router = proxyRouter.wrapped

        ExternalRouterConfigurationView(
            externalRouter: externalRouter,
            router: router
        ) {
            HierarchyConfigurationView(
                externalRouter: externalRouter,
                router: router
            ) {
                RoutelyActionsConfigurationView(router: router) {
                    content(proxyRouter)
                }
            }
        }
        .environment(router)
    }
}
