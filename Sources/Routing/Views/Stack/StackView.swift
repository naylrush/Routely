//
// Copyright © 2025 Движ
//

import RoutingInterfaces
import SwiftUI

struct StackView<Content: View, Destination: View>: View {
    @Environment(Router.self)
    private var router: Router

    @ViewBuilder let destination: (Route) -> Destination
    @ViewBuilder let content: Content

    var body: some View {
        @Bindable var router = router

        NavigationStack(path: $router.path) {
            StackHierarchyConfigurationView(id: nil) {
                content
            }
            .navigationDestination(for: IdentifiableModel<Route>.self) { identifiedRoute in
                StackSubviewConfigurationView {
                    StackHierarchyConfigurationView(id: identifiedRoute.id) {
                        destination(identifiedRoute.value)
                    }
                }
            }
        }
    }
}
