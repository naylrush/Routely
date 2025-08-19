//
// Copyright © 2025 Движ
//

import SwiftUI

public protocol EnhancedRouterProtocol<Wrapped>: RouterProtocol where Route == EnhancedRoute<Wrapped> {
    associatedtype Wrapped: RouteProtocol
}

extension EnhancedRouterProtocol {
    public func push(_ route: Route.Target) {
        push(.wrapped(route))
    }

    public func present(
        style: PresentationStyle,
        _ route: Route.Target,
        completion: (@MainActor () -> Void)? = nil
    ) {
        present(style: style, .wrapped(route), completion: completion)
    }

    public func present<T>(
        style: PresentationStyle,
        _ route: Route.Target,
        completion: @escaping @MainActor (T?) -> Void
    ) {
        present(style: style, .wrapped(route), completion: completion)
    }
}
