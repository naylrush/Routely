//
// Copyright © 2025 Движ
//

import RoutelyInterfaces

extension RouterState {
    public convenience init<ProxyRoute: ProxyRouteProtocol, BaseRoute: RouteProtocol>(
        _ state: RouterState<EnhancedRoute<BaseRoute>>
    ) where Route == EnhancedRoute<ProxyRoute>, ProxyRoute.Base == BaseRoute {
        let mappedPath = state.path.compactMap(IdentifiableModel<Route>.init)
        let mappedPresentationState = state.presentationState.flatMap(PresentationState<Route>.init)
        self.init(path: mappedPath, presentationState: mappedPresentationState)
    }

    public func into<ProxyRoute: ProxyRouteProtocol, BaseRoute: RouteProtocol>()
    -> RouterState<EnhancedRoute<BaseRoute>>
    where Route == EnhancedRoute<ProxyRoute>, ProxyRoute.Base == BaseRoute {
        .init(
            path: path.compactMap { $0.into() },
            presentationState: presentationState?.into()
        )
    }
}

extension PresentationState {
    public init?<ProxyRoute: ProxyRouteProtocol, BaseRoute: RouteProtocol>(
        _ state: PresentationState<EnhancedRoute<BaseRoute>>
    ) where Route == EnhancedRoute<ProxyRoute>, ProxyRoute.Base == BaseRoute {
        guard let mapped = RouteWithResult<Route>(state.routeWithResult) else { return nil }
        self.init(style: state.style, routeWithResult: mapped)
    }

    public func into<ProxyRoute: ProxyRouteProtocol, BaseRoute: RouteProtocol>()
    -> PresentationState<EnhancedRoute<BaseRoute>>?
    where Route == EnhancedRoute<ProxyRoute>, ProxyRoute.Base == BaseRoute {
        guard let mapped: RouteWithResult<EnhancedRoute<BaseRoute>> = routeWithResult.into() else { return nil }
        return .init(style: style, routeWithResult: mapped)
    }
}

extension RouteWithResult {
    public init?<ProxyRoute: ProxyRouteProtocol, BaseRoute: RouteProtocol>(
        _ value: RouteWithResult<EnhancedRoute<BaseRoute>>
    ) where Route == EnhancedRoute<ProxyRoute>, ProxyRoute.Base == BaseRoute {
        guard let mapped = Route(value.route) else { return nil }
        self.init(route: mapped, result: value.result)
    }

    public func into<ProxyRoute: ProxyRouteProtocol, BaseRoute: RouteProtocol>()
    -> RouteWithResult<EnhancedRoute<BaseRoute>>?
    where Route == EnhancedRoute<ProxyRoute>, ProxyRoute.Base == BaseRoute {
        guard let mapped: EnhancedRoute<BaseRoute> = route.into() else { return nil }
        return .init(route: mapped, result: result)
    }
}

extension IdentifiableModel {
    public init?<ProxyRoute: ProxyRouteProtocol, BaseRoute: RouteProtocol>(
        _ model: IdentifiableModel<EnhancedRoute<BaseRoute>>
    ) where T == EnhancedRoute<ProxyRoute>, ProxyRoute.Base == BaseRoute {
        guard let mapped = T(model.value) else { return nil }
        self.init(id: model.id, value: mapped)
    }

    public func into<ProxyRoute: ProxyRouteProtocol, BaseRoute: RouteProtocol>()
    -> IdentifiableModel<EnhancedRoute<BaseRoute>>?
    where T == EnhancedRoute<ProxyRoute>, ProxyRoute.Base == BaseRoute {
        guard let mapped: EnhancedRoute<BaseRoute> = value.into() else { return nil }
        return .init(id: id, value: mapped)
    }
}

extension EnhancedRoute where Base: ProxyRouteProtocol {
    public init?<NestedBase: RouteProtocol>(_ route: EnhancedRoute<NestedBase>) where Base.Base == NestedBase {
        if case let .wrapped(nestedBase) = route, let base = Base(nestedBase) {
            self = .wrapped(base)
        } else {
            return nil
        }
    }

    public func into<NestedBase: RouteProtocol>() -> EnhancedRoute<NestedBase>? where Base.Base == NestedBase {
        if case let .wrapped(base) = self, let nestedBase = base.toBase() {
            .wrapped(nestedBase)
        } else {
            nil
        }
    }
}
