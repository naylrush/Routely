//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
import SwiftUI

struct EnhancedRouterHolderView<Route: RouteDestinationProtocol, Content: View>: View {
    @State private var router = EnhancedRouter<Route>()

    @ViewBuilder let content: (EnhancedRouter<Route>) -> Content

    var body: some View {
        content(router)
            .environment(router)
    }
}
