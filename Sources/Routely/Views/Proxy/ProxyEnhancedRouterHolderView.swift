//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
import SwiftUI

struct ProxyEnhancedRouterHolderView<Route: ProxyRouteDestinationProtocol, Content: View>: View {
    @State private var router = ProxyEnhancedRouter<Route>()

    @ViewBuilder let content: (EnhancedRouter<Route>) -> Content

    var body: some View {
        content(router)
            .environment(router.wrapped)
    }
}
