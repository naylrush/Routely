//
// Copyright © 2025 Движ
//

import Foundation
import RoutelyInterfaces

@MainActor
public protocol Handler: Sendable {
    associatedtype DeepLink: DeepLinkProtocol

    func handle<Router: CompositeRouting>(
        router: Router,
        deepLink: DeepLink
    ) async throws where Router.Wrapped == DeepLink.Route
}
