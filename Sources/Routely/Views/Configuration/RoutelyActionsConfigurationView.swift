//
// Copyright © 2025 Движ
//

import SwiftUI

struct RoutelyActionsConfigurationView<Route: Routable, Content: View>: View {
    @Environment(\.routingResult)
    private var routingResult

    @Environment(\.finishWholeRoute)
    private var externalFinishWholeRoute

    let router: Router<Route>
    @ViewBuilder let content: Content

    var body: some View {
        let dismiss = RoutelyAction {
            router.dismiss()
        }

        let finishWholeRoute = FinishWholeRouteAction { value in
            if !externalFinishWholeRoute.isDummy {
                externalFinishWholeRoute(value)
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
