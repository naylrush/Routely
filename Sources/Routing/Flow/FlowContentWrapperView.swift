//
// Copyright © 2025 Движ
//

import OSLog
import RoutingInterfaces
import SwiftUI

struct FlowContentWrapperView<
    Route: RouteDestinationProtocol,
    FlowRoute: FlowRouteProtocol
>: View {
    typealias ExpandToRoute = (FlowRoute) -> Route

    @Environment(Router<Route>.self)
    private var router

    let route: FlowRoute
    let expandToRoute: ExpandToRoute

    var body: some View {
        expandToRoute(route).destination
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
        let nextRoute = expandToRoute(nextFlowRoute)

        switch nextFlowRoute.flowPresentationStyle {
        case .push:
            router.push(nextRoute)

        case let .present(style):
            router.present(style: style, nextRoute)
        }

        logger.debug(
            "\(String(describing: nextFlowRoute.flowPresentationStyle)) next route: \(String(describing: nextRoute))"
        )
    }
}

private let logger = Logger(subsystem: "Routing", category: "FlowContentWrapperView")
