//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
import SwiftUI

struct PresentingView<Route: ConvertibleRoutableDestination, Content: View>: View {
    typealias RealRouter = EnhancedRouter<Route>
    private typealias RealRoute = RealRouter.Route

    @Bindable var router: RealRouter
    @ViewBuilder let content: Content

    private var fullScreenRoute: Binding<RouteWithResult<RealRoute>?> {
        route($router.state.presentationState, withStyle: .fullScreen)
    }
    private var sheetRoute: Binding<RouteWithResult<RealRoute>?> {
        route($router.state.presentationState, withStyle: .sheet())
    }
    private var sheetDismissalBehavior: Binding<SheetDismissalBehavior> {
        $router.state.presentationState.map { $0?.style.sheetDismissalBehavior ?? .default }
    }

    var body: some View {
        content
            .fullScreen(item: fullScreenRoute) { routeWithResult in
                DestinationWrapper(routeWithResult: routeWithResult) { destination in
                    FullScreenContainer { destination }
                }
            }
            .dismissibleSheet(item: sheetRoute, behavior: sheetDismissalBehavior) { routeWithResult in
                DestinationWrapper(routeWithResult: routeWithResult) { $0 }
            }
    }

    private func DestinationWrapper<WrappedContent: View>(
        routeWithResult: RouteWithResult<RealRoute>,
        @ViewBuilder wrapping: (RealRoute.Destination) -> WrappedContent
    ) -> some View {
        DestinationConfigurationView(providedRoutelyResult: routeWithResult.result) {
            RootViewBuilder<Route.Target>.wrap(if: routeWithResult.route.wrapToRootView) {
                wrapping(routeWithResult.route.destination)
            }
        }
    }
}

private struct DestinationConfigurationView<Destination: View>: View {
    @Environment(\.routingResult)
    private var routingResult

    let providedRoutelyResult: RoutelyResult?
    @ViewBuilder let destination: Destination

    var body: some View {
        destination
            .environment(\.routingResult, providedRoutelyResult ?? routingResult)
    }
}

private func route<Route: Routable>(
    _ base: Binding<PresentationState<Route>?>,
    withStyle style: PresentationStyle
) -> Binding<RouteWithResult<Route>?> {
    base.mapOptional { state in
        if state.style.isSameKind(as: style) { state.routeWithResult } else { nil }
    }
}

extension PresentationStyle {
    fileprivate var sheetDismissalBehavior: SheetDismissalBehavior? {
        if case .sheet(let behavior) = self { behavior } else { nil }
    }
}

extension Binding where Value: Sendable {
    fileprivate func mapOptional<T, NewValue>(
        _ transform: @escaping @Sendable (T) -> NewValue?
    ) -> Binding<NewValue?> where T? == Value {
        Binding<NewValue?>(
            get: {
                wrappedValue.flatMap(transform)
            },
            set: { newValue in
                if newValue == nil {
                    wrappedValue = nil
                }
            }
        )
    }

    fileprivate func map<NewValue>(
        _ transform: @escaping @Sendable (Value) -> NewValue
    ) -> Binding<NewValue> {
        Binding<NewValue>(
            get: {
                transform(wrappedValue)
            },
            set: { _ in }
        )
    }
}
