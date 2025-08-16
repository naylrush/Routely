//
// Copyright © 2025 Движ
//

import DeepLinking
import OSLog
import RoutelyInterfaces
import SwiftUI

struct DeepLinkingView<Route: RouteProtocol, Content: View>: View {
    @Environment(\.isTopHierarchy)
    private var isTopHierarchy

    @Environment(\.isDeepLinkHandlingEnabled)
    private var isDeepLinkHandlingEnabled

    private let manager = DeepLinking.Manager.shared
    private let registry = DeepLinking.Registry.shared

    let router: Router<Route>
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
            let handled = try await registry.handle(router: router, rawDeepLink: rawDeepLink)
            if !handled {
                logger.warning("Could not handle deep link: \(rawDeepLink)")
            }
        } catch {
            logger.error("Got error while handling deep link: \(error)")
        }
    }
}

private let logger = Logger(subsystem: "Routely", category: "DeepLinking")
