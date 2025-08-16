//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
import SwiftUI

private struct DummyProxyRoute<Route: RouteDestinationProtocol>: ProxyRouteDestinationProtocol {
    let route: Route

    // Proxy
    typealias Base = Route

    nonisolated init?(_ route: Base) {
        self.route = route
    }

    nonisolated func toBase() -> Base? {
        route
    }

    // View
    var body: some View {
        route.destination
    }
}

public struct RootView<Route: RouteDestinationProtocol, Content: View>: View {
    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        ProxyRootView<DummyProxyRoute<Route>, _> {
            content
        }
    }
}

extension RootView where Content == Route.Destination {
    public init(initialRoute: Route) {
        self.init {
            initialRoute.destination
        }
    }
}

@MainActor
enum RootViewBuilder<Route: RouteDestinationProtocol> {
    @ViewBuilder
    static func wrap(
        `if` condition: Bool,
        @ViewBuilder content: () -> some View
    ) -> some View {
        if condition {
            RootView<Route, _>(content: content)
        } else {
            content()
        }
    }
}
