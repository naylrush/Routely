//
// Copyright © 2025 Движ
//

import Factory
import RoutingInterfaces
import SwiftUI

struct StackHierarchyConfigurationView<Route: RouteProtocol, Content: View>: View {
    @Injected(\.routingManager)
    private var routingManager

    let router: Router<Route>

    // nil for root view of stack
    let id: IdentifiableModel<Route>.ID?

    @ViewBuilder let content: Content

    var body: some View {
        content
            .environment(\.isLastInStack, router.path.last?.id == id)
    }
}
