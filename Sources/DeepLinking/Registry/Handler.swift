//
// Copyright © 2025 Движ
//

import Foundation
import RoutingInterfaces

@MainActor
public protocol Handler: Sendable {
    associatedtype DeepLink: DeepLinkProtocol

    func handle(router: RouterProtocol, deepLink: DeepLink) async throws
}
