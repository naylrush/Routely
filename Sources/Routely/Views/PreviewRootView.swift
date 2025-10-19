//
// Copyright © 2025 Движ
//

import SwiftUI

private struct PreviewConvertibleRoute<
    Route: Routable & WebRoutable
>: ConvertibleRoutableDestination, SelfConvertible, WebRoutable {
    let route: Route

    init(route: Route) {
        self.route = route
    }

    init?(url: URL) {
        if let route = Route(url: url) {
            self.route = route
        } else {
            return nil
        }
    }

    var body: some View {
        Text(String(describing: route))
    }
}

public struct PreviewRootView<Route: Routable & WebRoutable, Content: View>: View {
    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        RootContentView<PreviewConvertibleRoute<Route>, _> {
            content
        }
    }
}

@MainActor
public enum PreviewRootViewBuilder<Route: Routable & WebRoutable> {
    public static func make(content: () -> some View) -> some View {
        PreviewRootView<Route, _>(content: content)
    }
}
