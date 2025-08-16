//
// Copyright © 2025 Движ
//

import Foundation

public enum EnhancedRoute<Base: RouteProtocol>: ProxyRouteProtocol {
    case wrapped(Base)

    case safari(URL)

    public init?(_ base: Base) {
        self = .wrapped(base)
    }

    public func toBase() -> Base? {
        nil
    }
}
