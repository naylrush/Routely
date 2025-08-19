//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
import SwiftUI

private struct DummyProxyRoute<Route: RoutableDestination>: ConvertibleRoutableDestination {
    let route: Route

    // Convertible
    typealias Target = Route

    nonisolated init?(_ route: Target) {
        self.route = route
    }

    nonisolated func into() -> Target? {
        route
    }

    // View
    var body: some View {
        route.destination
    }

    var wrapToRootView: Bool {
        route.wrapToRootView
    }
}

public struct RootView<Route: RoutableDestination, Content: View>: View {
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
enum RootViewBuilder<Route: RoutableDestination> {
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
