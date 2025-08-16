//
// Copyright © 2025 Движ
//

import Foundation

public enum EnhancedRoute<Base: RouteProtocol>: RouteProtocol {
    case wrapped(Base)

    case safari(URL)
}

extension EnhancedRoute: ProxyRouteProtocol {
    public init?(_ base: Base) {
        self = .wrapped(base)
    }

    public func toBase() -> Base? {
        nil
    }
}
