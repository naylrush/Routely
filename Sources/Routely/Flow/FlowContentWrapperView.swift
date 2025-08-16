//
// Copyright © 2025 Движ
//

import OSLog
import RoutelyInterfaces
import SwiftUI

struct FlowContentWrapperView<FlowRoute: FlowRouteDestinationProtocol>: View {
    @Environment(EnhancedRouter<FlowRoute.Base>.self)
    private var router

    let route: FlowRoute

    var body: some View {
        route.destination
            .environment(\.next, .init(action: goToNext))
    }

    private func goToNext() {
        logger.debug("Going to next route, currentRoute: \(String(describing: route))")

        let allCases = FlowRoute.allCases
        guard let index = allCases.firstIndex(of: route) else {
            logger.fault("Index of currentRoute not found")
            return
        }

        let nextIndex = allCases.index(after: index)
        guard nextIndex != allCases.endIndex else {
            logger.fault("Next index is out of bounds")
            return
        }

        let nextFlowRoute = FlowRoute.allCases[nextIndex]
        guard let nextRoute = nextFlowRoute.toBase() else {
            logger.fault("Base convertion failed")
            return
        }

        router.push(nextRoute)

        logger.debug(
            "Pushed next flow's route: \(String(describing: nextRoute))"
        )
    }
}

private let logger = Logger(subsystem: "Routely", category: "FlowContentWrapperView")
