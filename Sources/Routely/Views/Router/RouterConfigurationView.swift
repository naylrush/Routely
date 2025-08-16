//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
import SwiftUI

struct RouterConfigurationView<Route: RouteDestinationProtocol, Content: View>: View {
    @Environment(EnhancedRouter<Route>.self)
    private var externalRouter: EnhancedRouter?

    let router: EnhancedRouter<Route>

    @ViewBuilder let content: Content

    var body: some View {
        ExternalRouterConfigurationView(
            externalRouter: externalRouter,
            router: router
        ) {
            HierarchyConfigurationView(
                externalRouter: externalRouter,
                router: router
            ) {
                RoutelyActionsConfigurationView(router: router) {
                    content
                }
            }
        }
    }
}
