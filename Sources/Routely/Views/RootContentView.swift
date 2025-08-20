//
// Copyright © 2025 Движ
//

import SwiftUI

struct RootContentView<ConvertibleRoute: ConvertibleRoutableDestination, Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        RouterConfigurationView<ConvertibleRoute, _> { router in
            OpenURLOverridingView(router: router) {
                PresentingView(router: router) {
                    StackView(router: router) {
                        DeepLinkingWrapperView(router: router) {
                            content
                        }
                    }
                }
            }
        }
    }
}

extension RootContentView where Content == ConvertibleRoute.Destination {
    init(initialRoute: ConvertibleRoute) {
        self.init {
            initialRoute.destination
        }
    }
}
