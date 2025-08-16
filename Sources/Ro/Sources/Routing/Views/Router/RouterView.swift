//
// Copyright © 2025 Движ
//

import SwiftUI

struct RouterView<Content: View>: View {
    @Environment(Router.self)
    private var externalRouter: Router?

    @State private var router = Router()

    @ViewBuilder let content: Content

    var body: some View {
        RouterConfigurationView(
            router: router,
            externalRouter: externalRouter
        ) {
            HierarchyConfigurationView(
                router: router,
                externalRouter: externalRouter
            ) {
                RoutelyActionsConfigurationView {
                    content
                }
            }
        }
        .environment(router)
    }
}
