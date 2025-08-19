//
// Copyright © 2025 Движ
//

import Foundation

public enum CompositeRoute<Wrapped: Routable>: Routable {
    case wrapped(Wrapped)

    case safari(URL)
}

extension CompositeRoute: ConvertibleRoutable {
    public init?(_ wrapped: Wrapped) {
        self = .wrapped(wrapped)
    }

    public func into() -> Wrapped? {
        nil
    }
}
