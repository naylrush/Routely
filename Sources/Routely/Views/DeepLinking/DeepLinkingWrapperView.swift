//
// Copyright © 2025 Движ
//

import OSLog
import SwiftUI

struct DeepLinkingWrapperView<Route: Routable, Content: View>: View {
    let router: Router<Route>

    @ViewBuilder var content: Content

    var body: some View {
        if DeepLinkingConfiguration.isEnabled {
            DeepLinkingView(router: router) {
                content
            }
        } else {
            content
        }
    }
}
