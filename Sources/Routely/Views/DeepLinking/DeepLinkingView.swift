//
// Copyright © 2025 Движ
//

import OSLog
import SwiftUI

struct DeepLinkingView<ConvertibleRoute: ConvertibleRoutable, Content: View>: View {
    @Environment(\.isTopHierarchy)
    private var isTopHierarchy

    @Environment(\.isDeepLinkHandlingEnabled)
    private var isDeepLinkHandlingEnabled

    let router: ConvertibleRouter<ConvertibleRoute>
    @ViewBuilder let content: Content

    var body: some View {
        content
            .onChange(of: isDeepLinkHandlingEnabled && isTopHierarchy, initial: true) { _, newValue in
                if newValue {
                    Task {
                        await handleDeepLinkIfPending()
                    }
                }
            }
            .onOpenDeepLink(
                perform: handleDeepLinkIfEnabled,
                if: isTopHierarchy
            )
    }

    private func handleDeepLinkIfPending() async {
        guard let rawDeepLink = DeepLinkingManager.shared.getPendingRawDeepLink() else { return }
        logger.debug("Handling pending deep link: \(rawDeepLink)")
        await handleDeepLink(rawDeepLink: rawDeepLink)
    }

    private func handleDeepLinkIfEnabled(rawDeepLink: RawDeepLink) async {
        if isDeepLinkHandlingEnabled {
            logger.debug("Handling deep link: \(rawDeepLink)")
            await handleDeepLink(rawDeepLink: rawDeepLink)
        } else {
            DeepLinkingManager.shared.setPendingRawDeepLink(rawDeepLink)
            logger.debug("Saved pending deep link: \(rawDeepLink)")
        }
    }

    private func handleDeepLink(rawDeepLink: RawDeepLink) async {
        await DeepLinkingRegistry.shared.loggingHandle(router: router.wrapped, rawDeepLink: rawDeepLink)
    }
}

private let logger = Logger(subsystem: "Routely", category: "DeepLinking")
