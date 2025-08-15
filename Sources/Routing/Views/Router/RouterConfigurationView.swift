//
// Copyright © 2025 Движ
//

import RoutingInterfaces
import SwiftUI

struct RouterConfigurationView<Route: RouteProtocol, Content: View>: View {
    private let router: Router<Route>
    private let externalRouter: Router<Route>?

    private let content: Content

    init(
        router: Router<Route>,
        externalRouter: Router<Route>?,
        @ViewBuilder content: () -> Content
    ) {
        self.router = router
        self.externalRouter = externalRouter

        router.onExternalRouterDismiss = { [weak externalRouter] in
            precondition(router !== externalRouter, "router and externalRouter should be different")
            externalRouter?.dismiss()
        }
        self.content = content()
    }

    var body: some View {
        content
    }
}
