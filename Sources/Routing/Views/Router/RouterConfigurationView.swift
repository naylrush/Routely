//
// Copyright © 2025 Движ
//

import SwiftUI

struct RouterConfigurationView<Content: View>: View {
    private let router: Router
    private let externalRouter: Router?

    private let content: Content

    init(
        router: Router,
        externalRouter: Router?,
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
