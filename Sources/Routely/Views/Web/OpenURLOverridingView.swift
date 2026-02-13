//
// Copyright © 2025 Движ
//

import SwiftUI

struct OpenURLOverridingView<Route: WebRoutable, Content: View>: View {
    @Environment(\.openURL)
    private var externalOpenUrl

    let router: Router<Route>
    @ViewBuilder let content: Content

    private var openUrlAction: OpenURLAction {
        OpenURLAction { url in
            if url.isWebUrl, let webRoute = Route(url: url) {
                router.present(style: .sheet(), webRoute)
            } else {
                externalOpenUrl(url)
            }
            return .handled
        }
    }

    var body: some View {
        content
            .environment(\.openURL, openUrlAction)
    }
}

extension URL {
    fileprivate var isWebUrl: Bool {
        ["http", "https"].contains(scheme?.lowercased())
    }
}
