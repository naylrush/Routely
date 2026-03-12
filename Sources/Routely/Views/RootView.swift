//
// Copyright © 2025 Движ
//

import SwiftUI

private struct DummyConvertibleRoute<
    Route: RoutableDestination & WebRoutable
>: ConvertibleRoutableDestination, WebRoutable {
    let route: Route

    // Convertible
    typealias Target = Route

    nonisolated init?(_ route: Target) {
        self.route = route
    }

    nonisolated func into() -> Target? {
        route
    }

    // WebRoutable
    nonisolated init?(url: URL) {
        if let route = Route(url: url) {
            self.route = route
        } else {
            return nil
        }
    }

    // View
    var body: some View {
        route
    }

    var wrapToRootView: Bool {
        route.wrapToRootView
    }
}

public struct RootView<Route: RoutableDestination & WebRoutable, Content: View>: View {
    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        RootContentView<DummyConvertibleRoute<Route>, _> {
            content
        }
    }
}

extension RootView where Content == Route {
    public init(initialRoute: Route) {
        self.init {
            initialRoute
        }
    }
}

@MainActor
enum RootViewBuilder<Route: RoutableDestination & WebRoutable> {
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
