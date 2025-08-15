//
// Copyright © 2025 Движ
//

import RoutingInterfaces
import SwiftUI

struct StackView<Route: RouteProtocol, Content: View, Destination: View>: View {
    @Bindable var router: Router<Route>
    @ViewBuilder let destination: (Route) -> Destination
    @ViewBuilder let content: Content

    var body: some View {
        NavigationStack(path: $router.path) {
            StackHierarchyConfigurationView(router: router, id: nil) {
                content
            }
            .navigationDestination(for: IdentifiableModel<Route>.self) { identifiedRoute in
                StackSubviewConfigurationView {
                    StackHierarchyConfigurationView(router: router, id: identifiedRoute.id) {
                        destination(identifiedRoute.value)
                    }
                }
            }
        }
    }
}
