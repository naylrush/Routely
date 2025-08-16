//
// Copyright © 2025 Движ
//

import RoutingInterfaces
import SwiftUI

struct StackView<Route: RouteDestinationProtocol, Content: View>: View {
    @Bindable var router: Router<Route>
    @ViewBuilder let content: Content

    var body: some View {
        NavigationStack(path: $router.state.path) {
            StackHierarchyConfigurationView(router: router, id: nil) {
                content
            }
            .navigationDestination(for: IdentifiableModel<Route>.self) { identifiedRoute in
                StackSubviewConfigurationView {
                    StackHierarchyConfigurationView(router: router, id: identifiedRoute.id) {
                        identifiedRoute.value.destination
                    }
                }
            }
        }
    }
}
