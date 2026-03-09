//
// Copyright © 2025 Движ
//

import OSLog
import SwiftUI

struct RoutelyActionsConfigurationView<Route: Routable, Content: View>: View {
    @Environment(\.routingResult)
    private var routingResult

    @Environment(\.finishWholeRoute)
    private var externalFinishWholeRoute

    let router: Router<Route>
    @ViewBuilder let content: Content

    var body: some View {
        let dismiss = RoutelyAction("dismiss") {
            router.dismiss()
        }

        let finishWholeRoute = FinishWholeRouteAction("finishWholeRoute") { value in
            if !routingResult.isDummy {
                routingResult.value = value
            }

            if !externalFinishWholeRoute.isDummy {
                externalFinishWholeRoute(value)
                return
            }

            dismiss(shouldLog: value is Void)
        }

        let finishCurrentRoute = RoutelyAction("finishCurrentRoute") {
            router.externalRouterDismiss()
        }

        content
            .environment(\.dvijDismiss, dismiss)
            .environment(\.finishWholeRoute, finishWholeRoute)
            .environment(\.finishCurrentRoute, finishCurrentRoute)
    }
}

private let logger = Logger(subsystem: "Routely", category: "RoutelyActionsConfigurationView")
