//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
import SwiftUI

struct RoutelyActionsConfigurationView<Route: Routable, Content: View>: View {
    @Environment(\.finishWholeRoute)
    private var finishWholeRoute

    let router: Router<Route>
    @ViewBuilder let content: Content

    var body: some View {
        let dismiss = RoutelyAction {
            router.dismiss()
        }

        let finishWholeRoute = finishWholeRoute.isDummy ? dismiss : finishWholeRoute

        let finishCurrentRoute = RoutelyAction {
            router.externalRouterDismiss()
        }

        content
            .environment(\.dvijDismiss, dismiss)
            .environment(\.finishWholeRoute, finishWholeRoute)
            .environment(\.finishCurrentRoute, finishCurrentRoute)
    }
}
