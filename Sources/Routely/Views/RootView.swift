//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
import SwiftUI

public struct RootView<
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

extension RootView where Content == Route.Destination {
    public init(route: Route) {
        self.init {
            route.destination
        }
    }
}

@MainActor
enum RootViewBuilder<Route: ProxyRouteDestinationProtocol> {
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
