//
// Copyright © 2025 Движ
//

import OSLog
import SwiftUI

struct FlowContentWrapperView<FlowRoute: FlowRoutableDestination>: View {
    @Environment(CompositeRouter<FlowRoute.Target>.self)
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
        goTo(nextFlowRoute)
    }

    private func goTo(_ nextFlowRoute: FlowRoute?) {
        guard let nextFlowRoute else { return }
        guard let nextRoute = nextFlowRoute.into() else {
            logger.fault("Target convertion failed")
            return
        }

        if case .present = route.flowPresentationStyle {
            routingResult.value = nextFlowRoute
            finishCurrentRoute()
            return
        }

        switch nextFlowRoute.flowPresentationStyle {
        case .push:
            router.push(nextRoute)

        case let .present(style):
            router.present(style: style, nextRoute, completion: goTo)
        }

        logger.debug(
            "\(nextFlowRoute.flowPresentationStyle) next route: \(String(describing: nextRoute))"
        )
    }
}

private let logger = Logger(subsystem: "Routely", category: "FlowContentWrapperView")
