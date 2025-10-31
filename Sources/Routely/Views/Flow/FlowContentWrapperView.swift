//
// Copyright © 2025 Движ
//

import OSLog
import SwiftUI

struct FlowContentWrapperView<FlowRoute: FlowRoutableDestination>: View {
    @Environment(Router<FlowRoute.Target>.self)
    private var router

    @Environment(\.routingResult)
    private var routingResult

    @Environment(\.finishCurrentRoute)
    private var finishCurrentRoute

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

        switch route.flowPresentationStyle {
        case .push:
            goTo(nextFlowRoute)

        case .present:
            // Parent will show next route
            routingResult[Keys.nextFlowRoute.rawValue] = nextFlowRoute
            finishCurrentRoute()
        }
    }

    private func goTo(_ nextFlowRoute: FlowRoute) {
        guard let nextRoute = nextFlowRoute.into() else {
            logger.fault("Target convertion failed")
            return
        }

        switch nextFlowRoute.flowPresentationStyle {
        case .push:
            router.push(nextRoute)

        case let .present(style):
            router.present(style: style, nextRoute, completion: onPresentationComplete)
        }

        logger.debug(
            "\(nextFlowRoute.flowPresentationStyle) next route: \(String(describing: nextRoute))"
        )
    }

    private func onPresentationComplete(
        _ routingResultValue: RoutelyResult.Value?,
        params: RoutelyResult.Params?
    ) {
        // Proxy
        routingResult.value = routingResultValue

        guard let nextFlowRoute = params?[Keys.nextFlowRoute.rawValue] as? FlowRoute else { return }
        goTo(nextFlowRoute)
    }
}

private enum Keys: String {
    case nextFlowRoute
}

private let logger = Logger(subsystem: "Routely", category: "FlowContentWrapperView")
