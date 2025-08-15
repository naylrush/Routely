//
// Copyright © 2025 Движ
//

import Factory
import RoutingInterfaces
import SwiftUI

struct HierarchyConfigurationView<Content: View>: View {
    @Injected(\.routingManager)
    private var routingManager

    let router: Router
    let externalRouter: Router?

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
