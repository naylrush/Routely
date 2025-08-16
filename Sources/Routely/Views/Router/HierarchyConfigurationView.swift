//
// Copyright © 2025 Движ
//

import Factory
import RoutelyInterfaces
import SwiftUI

struct HierarchyConfigurationView<Route: RouteProtocol, Content: View>: View {
    @Injected(\.routingManager)
    private var routingManager

    let router: Router<Route>
    let externalRouter: Router<Route>?

    @ViewBuilder let content: Content

    var body: some View {
        content
            .onAppear {
                routingManager.topRouterId = router.id
            }
            .onDisappear {
                if let externalId = externalRouter?.id {
                    routingManager.topRouterId = externalId
                }
            }
            .environment(\.isTopHierarchy, router.id == routingManager.topRouterId)
    }
}
