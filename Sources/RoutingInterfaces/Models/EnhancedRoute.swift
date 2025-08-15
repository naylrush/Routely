//
// Copyright © 2025 Движ
//

import Foundation

public enum EnhancedRoute<Wrapped: RouteProtocol>: RouteProtocol {
    public typealias Wrapped = Wrapped

    case wrapped(Wrapped)

    case safari(URL)
}
