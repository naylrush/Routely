//
// Copyright © 2025 Движ
//

import RoutingInterfaces
import SwiftUI

struct PresentingView<Route: RouteProtocol, Content: View, Destination: View>: View {
    @Bindable var router: Router<Route>
    @ViewBuilder let destination: (Route) -> Destination
    @ViewBuilder let content: Content

    private var fullScreenRoute: Binding<RouteWithResult<Route>?> {
        route($router.presentationState, withStyle: .fullScreen)
    }
    private var sheetRoute: Binding<RouteWithResult<Route>?> {
        route($router.presentationState, withStyle: .sheet())
    }
    private var sheetDismissalBehavior: Binding<SheetDismissalBehavior> {
        $router.presentationState.map { $0?.style.sheetDismissalBehavior ?? .default }
    }

    var body: some View {
        content
            .fullScreen(item: fullScreenRoute) { routeWithResult in
                DestinationConfigurationView(providedRoutingResult: routeWithResult.result) {
                    RootView.wrap(
                        if: routeWithResult.route.wrapToRootView,
                        destination: destination
                    ) {
                        FullScreenContainer {
                            destination(routeWithResult.route)
                        }
                    }
                }
            }
            .dismissibleSheet(
                item: sheetRoute,
                behavior: sheetDismissalBehavior
            ) { routeWithResult in
                DestinationConfigurationView(providedRoutingResult: routeWithResult.result) {
                    RootView.wrap(
                        if: routeWithResult.route.wrapToRootView,
                        destination: destination
                    ) {
                        destination(routeWithResult.route)
                    }
                }
            }
    }
}

private func route<Route: RouteProtocol>(
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
