//
// Copyright © 2025 Движ
//

import RoutelyInterfaces

extension RouterState {
    public convenience init<WrappedRoute: ProxyRouteProtocol, TargetRoute: RouteProtocol>(
        _ state: RouterState<EnhancedRoute<TargetRoute>>
    ) where Route == EnhancedRoute<WrappedRoute>, WrappedRoute.Target == TargetRoute {
        let path = state.path.compactMap(IdentifiableModel<Route>.init)
        let presentationState = state.presentationState.flatMap(PresentationState<Route>.init)
        self.init(path: path, presentationState: presentationState)
    }

    public func into<ProxyRoute: ProxyRouteProtocol, TargetRoute: RouteProtocol>()
    -> RouterState<EnhancedRoute<TargetRoute>>
    where Route == EnhancedRoute<ProxyRoute>, ProxyRoute.Target == TargetRoute {
        .init(
            path: path.compactMap { $0.into() },
            presentationState: presentationState?.into()
        )
    }
}

extension PresentationState {
    public init?<WrappedRoute: ProxyRouteProtocol, TargetRoute: RouteProtocol>(
        _ state: PresentationState<EnhancedRoute<TargetRoute>>
    ) where Route == EnhancedRoute<WrappedRoute>, WrappedRoute.Target == TargetRoute {
        guard let routeWithResult = RouteWithResult<Route>(state.routeWithResult) else { return nil }
        self.init(style: state.style, routeWithResult: routeWithResult)
    }

    public func into<WrappedRoute: ProxyRouteProtocol, TargetRoute: RouteProtocol>()
    -> PresentationState<EnhancedRoute<TargetRoute>>?
    where Route == EnhancedRoute<WrappedRoute>, WrappedRoute.Target == TargetRoute {
        guard let target: RouteWithResult<EnhancedRoute<TargetRoute>> = routeWithResult.into() else { return nil }
        return .init(style: style, routeWithResult: target)
    }
}

extension RouteWithResult {
    public init?<WrappedRoute: ProxyRouteProtocol, TargetRoute: RouteProtocol>(
        _ value: RouteWithResult<EnhancedRoute<TargetRoute>>
    ) where Route == EnhancedRoute<WrappedRoute>, WrappedRoute.Target == TargetRoute {
        guard let route = Route(value.route) else { return nil }
        self.init(route: route, result: value.result)
    }

    public func into<WrappedRoute: ProxyRouteProtocol, TargetRoute: RouteProtocol>()
    -> RouteWithResult<EnhancedRoute<TargetRoute>>?
    where Route == EnhancedRoute<WrappedRoute>, WrappedRoute.Target == TargetRoute {
        guard let target: EnhancedRoute<TargetRoute> = route.into() else { return nil }
        return .init(route: target, result: result)
    }
}

extension IdentifiableModel {
    public init?<Route: ProxyRouteProtocol, TargetRoute: RouteProtocol>(
        _ model: IdentifiableModel<EnhancedRoute<TargetRoute>>
    ) where T == EnhancedRoute<Route>, Route.Target == TargetRoute {
        guard let value = T(model.value) else { return nil }
        self.init(id: model.id, value: value)
    }

    public func into<Route: ProxyRouteProtocol, TargetRoute: RouteProtocol>()
    -> IdentifiableModel<EnhancedRoute<TargetRoute>>?
    where T == EnhancedRoute<Route>, Route.Target == TargetRoute {
        guard let target: EnhancedRoute<TargetRoute> = value.into() else { return nil }
        return .init(id: id, value: target)
    }
}

extension EnhancedRoute where Wrapped: ProxyRouteProtocol {
    public init?<NestedWrapped: RouteProtocol>(
        _ route: EnhancedRoute<NestedWrapped>
    ) where Wrapped.Target == NestedWrapped {
        if case let .wrapped(nestedWrapped) = route, let base = Wrapped(nestedWrapped) {
            self = .wrapped(base)
        } else {
            return nil
        }
    }

    public func into<NestedWrapped: RouteProtocol>()
    -> EnhancedRoute<NestedWrapped>?
    where Wrapped.Target == NestedWrapped {
        if case let .wrapped(wrapped) = self, let nestedWrapped = wrapped.into() {
            .wrapped(nestedWrapped)
        } else {
            nil
        }
    }
}
