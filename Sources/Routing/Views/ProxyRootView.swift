//
// Copyright © 2025 Движ
//

import RoutingInterfaces
import SwiftUI

public struct ProxyRootView<
    Route: ProxyRouteDestinationProtocol,
    Content: View
>: View {
    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        RouterView<Route, _> { router in
            ProxyRootContentView(router: router) {
                content
            }
        }
    }
}

extension ProxyRootView where Content == Route.Destination {
    public init(route: Route) {
        self.init {
            route.destination
        }
    }
}

@MainActor
public enum ProxyRootViewBuilder<Route: ProxyRouteDestinationProtocol> {
    @ViewBuilder
    static func wrap(
        `if` condition: Bool,
        @ViewBuilder content: () -> some View
    ) -> some View {
        if condition {
            ProxyRootView<Route, _>(content: content)
        } else {
            content()
        }
    }
}
