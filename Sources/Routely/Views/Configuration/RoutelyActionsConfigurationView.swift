//
// Copyright © 2025 Движ
//

import SwiftUI

struct RoutelyActionsConfigurationView<Route: Routable, Content: View>: View {
    @Environment(\.routingResult)
    private var routingResult

    @Environment(\.finishWholeRoute)
    private var finishWholeRoute

    let router: Router<Route>
    @ViewBuilder let content: Content

    var body: some View {
        let dismiss = RoutelyAction {
            router.dismiss()
        }

        let finishWholeRoute = FinishWholeRouteAction { [finishWholeRoute, routingResult, dismiss] value in
            if !finishWholeRoute.isDummy {
                finishWholeRoute(value)
                return
            }

            if !routingResult.isDummy {
                routingResult.value = value
            }
            dismiss()
        }

        let finishCurrentRoute = RoutelyAction {
            router.externalRouterDismiss()
        }

        content
            .environment(\.dvijDismiss, dismiss)
            .environment(\.finishWholeRoute, finishWholeRoute)
            .environment(\.finishCurrentRoute, finishCurrentRoute)
    }
}
