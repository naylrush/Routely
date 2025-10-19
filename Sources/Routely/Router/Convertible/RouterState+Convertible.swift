//
// Copyright © 2025 Движ
//

extension RouterState where Route: ConvertibleRoutable {
    init(_ state: RouterState<Route.Target>) {
        let path = state.path.compactMap(IdentifiableModel<Route>.init)
        let presentationState = state.presentationState.flatMap(PresentationState<Route>.init)
        self.init(path: path, presentationState: presentationState)
    }

    func into() -> RouterState<Route.Target> {
        .init(
            path: path.compactMap { $0.into() },
            presentationState: presentationState?.into()
        )
    }
}

extension PresentationState where Route: ConvertibleRoutable {
    init?(_ state: PresentationState<Route.Target>) {
        guard let routeWithResult = RouteWithResult<Route>(state.routeWithResult) else { return nil }
        self.init(style: state.style, routeWithResult: routeWithResult)
    }

    func into() -> PresentationState<Route.Target>? {
        guard let target: RouteWithResult<Route.Target> = routeWithResult.into() else { return nil }
        return .init(style: style, routeWithResult: target)
    }
}

extension RouteWithResult where Route: ConvertibleRoutable {
    init?(
        _ value: RouteWithResult<Route.Target>
    ) {
        guard let route = Route(value.route) else { return nil }
        self.init(route: route, result: value.result)
    }

    func into() -> RouteWithResult<Route.Target>? {
        guard let target: Route.Target = route.into() else { return nil }
        return .init(route: target, result: result)
    }
}

extension IdentifiableModel where T: ConvertibleRoutable {
    public init?(_ model: IdentifiableModel<T.Target>) {
        guard let value = T(model.value) else { return nil }
        self.init(id: model.id, value: value)
    }

    public func into() -> IdentifiableModel<T.Target>? {
        guard let target: T.Target = value.into() else { return nil }
        return .init(id: id, value: target)
    }
}
