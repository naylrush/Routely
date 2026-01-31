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

    private let manager = DeepLinkingManager.shared
    private let registry = DeepLinkingRegistry.shared

    let router: ConvertibleRouter<ConvertibleRoute>
    @ViewBuilder let content: Content

    var body: some View {
        content
            .task {
                await handleDeepLinkIfPending()
            }
            .onOpenDeepLink(
                perform: handleDeepLink,
                if: isTopHierarchy
            )
    }

    private func handleDeepLinkIfPending() async {
        guard
            isTopHierarchy,
            let rawDeepLink = manager.pendingRawDeepLink
        else { return }

        logger.debug("Handling pending deep link: \(rawDeepLink)")
        manager.pendingRawDeepLink = nil
        await handleDeepLink(rawDeepLink: rawDeepLink)
    }

    private func handleDeepLink(rawDeepLink: RawDeepLink) async {
        guard isDeepLinkHandlingEnabled else {
            manager.pendingRawDeepLink = rawDeepLink
            logger.debug("Saved pending deep link: \(rawDeepLink)")
            return
        }

        do {
            let handled = try await registry.handle(router: router.wrapped, rawDeepLink: rawDeepLink)
            if handled {
                logger.debug("Handled deep link: \(rawDeepLink)")
            } else {
                logger.warning("Could not handle deep link: \(rawDeepLink)")
            }
        } catch {
            logger.error("Got error while handling deep link: \(error)")
        }
    }
}

private let logger = Logger(subsystem: "Routely", category: "DeepLinking")
