//
// Copyright © 2025 Движ
//

import RoutingInterfaces
import SwiftUI

public struct RootView<Route: RouteDestinationProtocol, Content: View>: View {
    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        RouterView<Route, _> { router in
            OpenURLOverridingView(router: router) {
                PresentingView(router: router) {
                    StackView(router: router) {
                        DeepLinkingView(router: router) {
                            content
                        }
                    }
                }
            }
        }
    }
}

@MainActor
public enum RootViewBuilder<Route: RouteDestinationProtocol> {
    static func make(
        content: () -> some View
    ) -> some View {
        RootView<Route, _>(content: content)
    }

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
