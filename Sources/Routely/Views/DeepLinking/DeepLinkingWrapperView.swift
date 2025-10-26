//
// Copyright © 2025 Движ
//

import OSLog
import SwiftUI

struct DeepLinkingWrapperView<ConvertibleRoute: ConvertibleRoutable, Content: View>: View {
    let router: ConvertibleRouter<ConvertibleRoute>

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
