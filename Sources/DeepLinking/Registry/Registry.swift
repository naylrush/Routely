//
// Copyright © 2025 Движ
//

import Foundation
import OSLog
import RoutelyInterfaces

@MainActor
public final class Registry {
    public static let shared = Registry()

    private var entries: [any DeepLinkEntryProtocol] = []

    public func register<E: DeepLinkEntryProtocol>(_ entry: E) {
        entries.append(entry)
    }

    public func handle(
        router: any CompositeRouting,
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
}

extension DeepLinkEntryProtocol {
    fileprivate func parseAndHandle(
        router: any CompositeRouting,
        rawDeepLink: RawDeepLink
    ) async throws -> Bool {
        guard let router = router as? any CompositeRouting<DeepLink.Route>,
              let deepLink = try await parseDeepLink(rawDeepLink: rawDeepLink) else { return false }
        let handler = try await makeHandler()
        try await handler.handle(router: router, deepLink: deepLink)
        return true
    }
}
