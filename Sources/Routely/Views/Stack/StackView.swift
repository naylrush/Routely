//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
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
                StackHierarchyConfigurationView(router: router, id: identifiedRoute.id) {
                    StackSubviewConfigurationView {
                        identifiedRoute.value.destination
                    }
                }
            }
        }
    }
}
