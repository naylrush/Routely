//
// Copyright © 2025 Движ
//

import SwiftUI

private struct PreviewConvertibleRoute<Route: Routable>: ConvertibleRoutableDestination, SelfConvertible {
    let route: Route

    var body: some View {
        Text(String(describing: route))
    }
}

public struct PreviewRootView<Route: Routable, Content: View>: View {
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
public enum PreviewRootViewBuilder<Route: Routable> {
    public static func make(content: () -> some View) -> some View {
        PreviewRootView<Route, _>(content: content)
    }
}
