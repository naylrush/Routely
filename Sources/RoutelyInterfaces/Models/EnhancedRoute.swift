//
// Copyright © 2025 Движ
//

import Foundation

public enum EnhancedRoute<Wrapped: RouteProtocol>: RouteProtocol {
    case wrapped(Wrapped)

    case safari(URL)
}

extension EnhancedRoute: ProxyRouteProtocol {
    public init?(_ wrapped: Wrapped) {
        self = .wrapped(wrapped)
    }

    public func into() -> Wrapped? {
        nil
    }
}
