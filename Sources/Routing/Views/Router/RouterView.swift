//
// Copyright © 2025 Движ
//

import RoutingInterfaces
import SwiftUI

struct RouterView<Route: RouteProtocol, Content: View>: View {
    @Environment(Router<Route>.self)
    private var externalRouter: Router?

    @State private var router = Router<Route>()
    @ViewBuilder let content: (Router<Route>) -> Content

    var body: some View {
        RouterConfigurationView(
            router: router,
            externalRouter: externalRouter
        ) {
            HierarchyConfigurationView(
                router: router,
                externalRouter: externalRouter
            ) {
                RoutingActionsConfigurationView(router: router) {
                    content(router)
                }
            }
        }
        .environment(router)
    }
}
