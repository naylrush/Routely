//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
import SwiftUI

struct OpenURLOverridingView<Route: Routable, Content: View>: View {
    let router: CompositeRouter<Route>
    @ViewBuilder let content: Content

    private var openUrlAction: OpenURLAction {
        OpenURLAction { url in
            router.present(style: .sheet(), .safari(url))
            return .handled
        }
    }

    var body: some View {
        content
            .environment(\.openURL, openUrlAction)
    }
}
