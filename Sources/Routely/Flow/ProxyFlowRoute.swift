//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
import SwiftUI

struct ProxyFlowRoute<FlowRoute: FlowRouteDestinationProtocol>: FlowRouteDestinationProtocol {
    let route: FlowRoute

    nonisolated init(_ route: FlowRoute) {
        self.route = route
    }

    // CaseIterable
    nonisolated static var allCases: [ProxyFlowRoute<FlowRoute>] {
        FlowRoute.allCases.map { Self.init($0) }
    }

    // ProxyRouteProtocol
    typealias Target = FlowRoute.Target

    nonisolated init?(_ base: FlowRoute.Target) {
        if let route = FlowRoute(base) {
            self.route = route
        } else {
            return nil
        }
    }

    nonisolated func into() -> FlowRoute.Target? {
        route.into()
    }

    // View
    var body: some View {
        FlowContentWrapperView(route: route)
    }

    var wrapToRootView: Bool {
        route.wrapToRootView
    }
}
