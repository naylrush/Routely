//
// Copyright © 2025 Движ
//

import RoutingInterfaces
import SwiftUI

public struct RootView<Route: RouteProtocol, Content: View, Destination: View>: View {
    public typealias DestinationBuilder = (Route) -> Destination

    private let destination: DestinationBuilder
    private let content: Content

    public init(
        @ViewBuilder destination: @escaping DestinationBuilder,
        @ViewBuilder content: () -> Content
    ) {
        self.destination = destination
        self.content = content()
    }

    public var body: some View {
        RouterView { router in
            OpenURLOverridingView(router: router) {
                PresentingView(router: router, destination: destination) {
                    StackView(router: router, destination: destination) {
                        DeepLinkingView(router: router) {
                            content
                        }
                    }
                }
            }
        }
    }
}

extension RootView {
    @ViewBuilder
    public static func wrap(
        `if` condition: Bool,
        @ViewBuilder destination: @escaping DestinationBuilder,
        @ViewBuilder content: () -> Content
    ) -> some View {
        if condition {
            RootView(destination: destination, content: content)
        } else {
            content()
        }
    }
}

@MainActor
public enum RootViewBuilder<Route: RouteProtocol> {
    static func make(
        destination: @escaping (Route) -> some View,
        content: () -> some View
    ) -> some View {
        RootView<Route, _, _>(destination: destination, content: content)
    }
}
