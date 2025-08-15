//
// Copyright © 2025 Движ
//

import RoutingInterfaces
import SwiftUI

struct OpenURLOverridingView<Route: RouteProtocol, Content: View>: View {
    let router: Router<Route>
    @ViewBuilder let content: Content

    private var openUrlAction: OpenURLAction {
        OpenURLAction { url in
//            router.present(style: .sheet(), .safari(url))
            return .handled
        }
    }

    var body: some View {
        content
            .environment(\.openURL, openUrlAction)
    }
}
