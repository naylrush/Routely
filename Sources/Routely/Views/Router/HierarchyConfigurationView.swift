//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
import SwiftUI

struct HierarchyConfigurationView<Route: Routable, Content: View>: View {
    private let manager = RouterManager.shared

    let externalRouter: Router<Route>?
    let router: Router<Route>

    @ViewBuilder let content: Content

    var body: some View {
        content
            .onAppear {
                manager.topRouterId = router.id
            }
            .onDisappear {
                if let externalId = externalRouter?.id {
                    manager.topRouterId = externalId
                }
            }
            .environment(\.isTopHierarchy, router.id == manager.topRouterId)
    }
}
