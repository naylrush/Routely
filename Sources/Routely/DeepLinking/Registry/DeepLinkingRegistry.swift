//
// Copyright © 2025 Движ
//

import Foundation
import OSLog

@MainActor
public final class DeepLinkingRegistry {
    public static let shared = DeepLinkingRegistry()

    private var entries: [any DeepLinkEntryProtocol] = []

    public func register<E: DeepLinkEntryProtocol>(_ entry: E) {
        entries.append(entry)
    }

    public func handle(
        router: any Routing,
        rawDeepLink: RawDeepLink
    ) async throws -> Bool {
        for entry in entries where try await entry.parseAndHandle(
            router: router,
            rawDeepLink: rawDeepLink
        ) {
            return true
        }
        return false
    }

    public func loggingHandle(
        router: any Routing,
        rawDeepLink: RawDeepLink
    ) async {
        do {
            let handled = try await handle(router: router, rawDeepLink: rawDeepLink)
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

extension DeepLinkEntryProtocol {
    fileprivate func parseAndHandle(
        router: any Routing,
        rawDeepLink: RawDeepLink
    ) async throws -> Bool {
        guard let router = router as? any Routing<DeepLinkType.Route>,
              let deepLink = try parseDeepLink(rawDeepLink: rawDeepLink) else { return false }
        let handler = try makeHandler()
        try await handler.handle(router: router, deepLink: deepLink)
        return true
    }
}

private let logger = Logger(subsystem: "Routely", category: "DeepLinking")
