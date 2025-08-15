//
// Copyright © 2025 Движ
//

import RoutingInterfaces
import SwiftUI

struct RoutingActionsConfigurationView<Route: RouteProtocol, Content: View>: View {
    @Environment(\.finishWholeRoute)
    private var finishWholeRoute

    let router: Router<Route>
    @ViewBuilder let content: Content

    var body: some View {
        let dismiss = RoutingAction {
            router.dismiss()
        }

        let finishWholeRoute = finishWholeRoute.isDummy ? dismiss : finishWholeRoute

        let finishCurrentRoute = RoutingAction {
            router.externalRouterDismiss()
        }

        content
            .environment(\.dvijDismiss, dismiss)
            .environment(\.finishWholeRoute, finishWholeRoute)
            .environment(\.finishCurrentRoute, finishCurrentRoute)
    }
}
