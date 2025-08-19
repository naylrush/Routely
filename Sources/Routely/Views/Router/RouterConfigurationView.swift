//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
import SwiftUI

struct RouterConfigurationView<Route: ConvertibleRoutableDestination, Content: View>: View {
    @Environment(CompositeRouter<Route.Target>.self)
    private var externalRouter: CompositeRouter?

    @State private var compositeRouter = CompositeConvertibleRouter<Route>()

    @ViewBuilder let content: (CompositeConvertibleRouter<Route>) -> Content

    var body: some View {
        let router = compositeRouter.wrapped

        ExternalRouterConfigurationView(
            externalRouter: externalRouter,
            router: router
        ) {
            HierarchyConfigurationView(
                externalRouter: externalRouter,
                router: router
            ) {
                RoutelyActionsConfigurationView(router: router) {
                    content(compositeRouter)
                }
            }
        }
        .environment(router)
    }
}
