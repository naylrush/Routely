//
// Copyright © 2025 Движ
//

import SwiftUI

struct StackHierarchyConfigurationView<Route: Routable, Content: View>: View {
    let router: Router<Route>

    // nil for root view of stack
    let id: IdentifiableModel<Route>.ID?

    @ViewBuilder let content: Content

    var body: some View {
        content
            .environment(\.isLastInStack, router.state.path.last?.id == id)
    }
}
