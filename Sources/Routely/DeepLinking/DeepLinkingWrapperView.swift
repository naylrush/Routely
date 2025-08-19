//
// Copyright © 2025 Движ
//

import DeepLinking
import OSLog
import RoutelyInterfaces
import SwiftUI

struct DeepLinkingWrapperView<Route: ConvertibleRoutableDestination, Content: View>: View {
    let router: CompositeConvertibleRouter<Route>

    @ViewBuilder var content: Content

    var body: some View {
        if DeepLinking.Configuration.isEnabled {
            DeepLinkingView(router: router) {
                content
            }
        } else {
            content
        }
    }
}
