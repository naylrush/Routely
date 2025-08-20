//
// Copyright © 2025 Движ
//

import OSLog
import SwiftUI

extension View {
    public func onOpenDeepLink(
        perform: @Sendable @escaping (RawDeepLink) async -> Void,
        `if` condition: Bool
    ) -> some View {
        onOpenURL { url in
            guard condition else { return }

            guard let deepLink = LinkParser.parseDeepLink(url: url) else {
                logger.error("Failed to parse deeplink: \(url)")
                return
            }
            Task {
                await perform(deepLink)
            }
        }
    }
}

private let logger = Logger(subsystem: "DeepLinking", category: "URL Parsing")
