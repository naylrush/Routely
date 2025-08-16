//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
import SwiftUI

struct HierarchyConfigurationView<Route: RouteProtocol, Content: View>: View {
    private let manager = Manager.shared

    let router: Router<Route>
    let externalRouter: Router<Route>?

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
