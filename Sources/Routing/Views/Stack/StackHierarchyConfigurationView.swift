//
// Copyright © 2025 Движ
//

import Factory
import RoutingInterfaces
import SwiftUI

struct StackHierarchyConfigurationView<Content: View>: View {
    @Injected(\.routingManager)
    private var routingManager

    @Environment(Router.self)
    private var router

    // nil for root view of stack
    let id: IdentifiableModel<Route>.ID?

    @ViewBuilder let content: Content

    var body: some View {
        content
            .environment(\.isLastInStack, router.path.last?.id == id)
    }
}
