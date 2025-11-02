//
// Copyright © 2025 Движ
//

import OSLog
import SwiftUI

extension View {
    public typealias RawDeepLinkHandler = @Sendable (RawDeepLink) async -> Void
    private typealias URLHandler = (URL) -> Void

    public func onOpenDeepLink(
        perform: @escaping RawDeepLinkHandler,
        `if` condition: Bool
    ) -> some View {
        let handler: URLHandler = { url in
            Self.handleUrl(url: url, perform: perform, condition: condition)
        }

        return self
            .onOpenURL(perform: handler)
            .onOpenUniversalLink(perform: handler)
    }

    private func onOpenUniversalLink(
        perform: @escaping URLHandler,
    ) -> some View {
        // Handles: Camera QR codes, Spotlight, Handoff
        onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { userActivity in
            if let url = userActivity.webpageURL {
                perform(url)
            }
        }
    }

    private static func handleUrl(
        url: URL,
        perform: @escaping RawDeepLinkHandler,
        condition: Bool
    ) {
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

private let logger = Logger(subsystem: "DeepLinking", category: "URL Parsing")
