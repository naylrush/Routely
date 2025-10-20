//
// Copyright © 2025 Движ
//

import SwiftUI

struct ExternalRouterConfigurationView<Route: Routable, Content: View>: View {
    private let content: Content

    init(
        externalRouter: Router<Route>?,
        router: Router<Route>,
        @ViewBuilder content: () -> Content
    ) {
        if let externalRouter {
            precondition(router !== externalRouter, "router and externalRouter should be different")
            router.onExternalRouterDismiss = {
                externalRouter.dismiss()
            }
        }

        self.content = content()
    }

    var body: some View {
        content
    }
}
