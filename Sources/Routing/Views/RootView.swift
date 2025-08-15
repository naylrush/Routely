//
// Copyright © 2025 Движ
//

import RoutingInterfaces
import SwiftUI

public struct RootView<Content: View, Destination: View>: View {
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
        RouterView {
            OpenURLOverridingView {
                PresentingView(destination: destination) {
                    StackView(destination: destination) {
                        DeepLinkingView {
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
