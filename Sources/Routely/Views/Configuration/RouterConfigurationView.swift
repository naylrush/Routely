//
// Copyright © 2025 Движ
//

import SwiftUI

struct RouterConfigurationView<ConvertibleRoute: ConvertibleRoutableDestination, Content: View>: View {
    @Environment(Router<ConvertibleRoute.Target>.self)
    private var externalRouter: Router?

    @State private var convertibleRouter = ConvertibleRouter<ConvertibleRoute>()

    @ViewBuilder let content: (ConvertibleRouter<ConvertibleRoute>) -> Content

    var body: some View {
        let router = convertibleRouter.wrapped

        ExternalRouterConfigurationView(
            externalRouter: externalRouter,
            router: router
        ) {
            HierarchyConfigurationView(
                externalRouter: externalRouter,
                router: router
            ) {
                RoutelyActionsConfigurationView(router: router) {
                    content(convertibleRouter)
                }
            }
        }
        .environment(router)
    }
}
