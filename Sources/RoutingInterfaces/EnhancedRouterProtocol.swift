//
// Copyright © 2025 Движ
//

import SwiftUI

public protocol EnhancedRouterProtocol: RouterProtocol where Route == EnhancedRoute<Wrapped> {
    associatedtype Wrapped: RouteProtocol
}

extension EnhancedRouterProtocol {
    func push(_ route: Route.Wrapped) {
        push(.wrapped(route))
    }

    func present(style: PresentationStyle, _ route: Route.Wrapped, completion: (@MainActor () -> Void)? = nil) {
        present(style: style, .wrapped(route), completion: completion)
    }

    func present<T>(style: PresentationStyle, _ route: Route.Wrapped, completion: @escaping @MainActor (T?) -> Void) {
        present(style: style, .wrapped(route), completion: completion)
    }
}
