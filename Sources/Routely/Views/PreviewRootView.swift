//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
import SwiftUI

private struct PreviewProxyRoute<Route: RouteProtocol>: ProxyRouteDestinationProtocol {
    let route: Route

    var body: some View {
        Text(String(describing: route))
    }
}

public struct PreviewRootView<Route: RouteProtocol, Content: View>: View {
    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        ProxyRootView<PreviewProxyRoute<Route>, _> {
            content
        }
    }
}

@MainActor
public enum PreviewRootViewBuilder<Route: RouteProtocol> {
    public static func make(content: () -> some View) -> some View {
        PreviewRootView<Route, _>(content: content)
    }
}
