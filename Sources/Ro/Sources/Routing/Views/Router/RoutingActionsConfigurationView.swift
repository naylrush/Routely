//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
import SwiftUI

struct RoutelyActionsConfigurationView<Content: View>: View {
    @Environment(\.finishWholeRoute)
    private var finishWholeRoute

    @Environment(Router.self)
    private var router

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
