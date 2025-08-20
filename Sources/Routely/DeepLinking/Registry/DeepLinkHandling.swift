//
// Copyright © 2025 Движ
//

import Foundation

@MainActor
public protocol DeepLinkHandling: Sendable {
    associatedtype DeepLinkType: DeepLink

    func handle<Router: CompositeRouting>(
        router: Router,
        deepLink: DeepLinkType
    ) async throws where Router.Wrapped == DeepLinkType.Route
}
