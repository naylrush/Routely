//
// Copyright © 2025 Движ
//

import SwiftUI

struct FlowConvertibleRoute<FlowRoute: FlowRoutableDestination>: FlowRoutableDestination {
    let route: FlowRoute

    nonisolated init(_ route: FlowRoute) {
        self.route = route
    }

    // CaseIterable
    nonisolated static var allCases: [FlowConvertibleRoute<FlowRoute>] {
        FlowRoute.allCases.map { Self.init($0) }
    }

    // ConvertibleRoutable
    typealias Target = FlowRoute.Target
    typealias FromType = Target
    typealias IntoType = Target?

    nonisolated init?(_ target: FlowRoute.Target) {
        if let route = FlowRoute(target) {
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
