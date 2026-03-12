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
        route
            .environment(\.next, .init("next", action: goToNext))
    }

    private func goToNext() {
        log("Going to next route in style \(route.flowPresentationStyle), currentRoute: \(String(describing: route))")

        let allCases = FlowRoute.allCases
        guard let index = allCases.firstIndex(of: route) else {
            log(level: .fault, "Index of currentRoute not found")
            return
        }

        let nextIndex = allCases.index(after: index)
        guard nextIndex != allCases.endIndex else {
            log(level: .fault, "Next index is out of bounds")
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
            log(level: .fault, "Target convertion failed")
            return
        }

        switch nextFlowRoute.flowPresentationStyle {
        case .push:
            router.push(nextRoute)

        case let .present(style):
            router.present(style: style, nextRoute, completion: onPresentationComplete)
        }
    }

    private func onPresentationComplete(
        _ routingResultValue: RoutelyResult.Value?,
        params: RoutelyResult.Params?
    ) {
        if let routingResultValue {
            // Proxy
            routingResult.value = routingResultValue
        }

        guard let nextFlowRoute = params?[Keys.nextFlowRoute.rawValue] as? FlowRoute else { return }
        goTo(nextFlowRoute)
    }

    nonisolated private func log(level: OSLogType = .debug, _ message: String) {
        logger.log(level: level, "[\(router.id)] \(message)")
    }
}

private enum Keys: String {
    case nextFlowRoute
}

private let logger = Logger(subsystem: "Routely", category: "FlowContentWrapperView")
