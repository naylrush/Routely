//
// Copyright © 2025 Движ
//

import Foundation

@MainActor
public protocol DeepLinkHandling: Sendable {
    associatedtype DeepLinkType: DeepLink

    func handle<Router: Routing>(
        router: Router,
        deepLink: DeepLinkType
    ) async throws where Router.Route == DeepLinkType.Route
}
