//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
import SwiftUI

public struct PreviewRootView<Content: View>: View {
    private let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        RootView(
            destination: DescribingDestination,
            content: content
        )
    }

    private func DescribingDestination(_ route: Route) -> some View {
        Text(String(describing: route))
    }
}
