//
// Copyright © 2025 Движ
//

import RoutelyInterfaces

extension RouterState where Route: ProxyRouteProtocol {
    convenience init(_ base: RouterState<Route.Base>) {
        self.init(
            path: base.path.compactMap(IdentifiableModel<Route>.init),
            presentationState: base.presentationState.flatMap(PresentationState.init),
        )
    }

    func toBase() -> RouterState<Route.Base> {
        .init(
            path: path.compactMap { $0.toBase() },
            presentationState: presentationState?.toBase()
        )
    }
}

extension RouteWithResult: Proxy where Route: ProxyRouteProtocol {
    typealias Base = RouteWithResult<Route.Base>

    init?(_ base: RouteWithResult<Route.Base>) {
        if let route = Route(base.route) {
            self.init(route: route, result: base.result)
        } else {
            return nil
        }
    }

    func toBase() -> RouteWithResult<Route.Base>? {
        if let baseRoute = route.toBase() {
            .init(route: baseRoute, result: result)
        } else {
            nil
        }
    }
}

extension PresentationState: Proxy where Route: ProxyRouteProtocol {
    typealias Base = PresentationState<Route.Base>

    init?(_ base: PresentationState<Route.Base>) {
        if let routeWithResult = RouteWithResult<Route>(base.routeWithResult) {
            self.init(style: base.style, routeWithResult: routeWithResult)
        } else {
            return nil
        }
    }

    func toBase() -> PresentationState<Route.Base>? {
        if let baseRouteWithResult = routeWithResult.toBase() {
            .init(style: style, routeWithResult: baseRouteWithResult)
        } else {
            nil
        }
    }
}

extension IdentifiableModel: Proxy where T: ProxyRouteProtocol {
    public typealias Base = IdentifiableModel<T.Base>

    public init?(_ base: IdentifiableModel<T.Base>) {
        if let value = T(base.value) {
            self.init(id: base.id, value: value)
        } else {
            return nil
        }
    }

    public func toBase() -> IdentifiableModel<T.Base>? {
        if let baseValue = value.toBase() {
            .init(id: id, value: baseValue)
        } else {
            nil
        }
    }
}
