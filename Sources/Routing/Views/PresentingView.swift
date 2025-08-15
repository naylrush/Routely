//
// Copyright © 2025 Движ
//

import RoutingInterfaces
import SwiftUI
import Toolbox

struct PresentingView<Content: View, Destination: View>: View {
    @Environment(Router.self)
    private var router: Router

    @ViewBuilder let destination: (Route) -> Destination
    @ViewBuilder let content: Content

    private var fullScreenRoute: Binding<RouteWithResult?> {
        @Bindable var router = router
        return $router.presentationState.route(withStyle: .fullScreen)
    }
    private var sheetRoute: Binding<RouteWithResult?> {
        @Bindable var router = router
        return $router.presentationState.route(withStyle: .sheet())
    }
    private var sheetDismissalBehavior: Binding<SheetDismissalBehavior> {
        @Bindable var router = router
        return $router.presentationState.sheetDismissalBehavior()
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

extension Binding<PresentationState?> {
    fileprivate func route(
        withStyle style: PresentationStyle
    ) -> Binding<RouteWithResult?> {
        mapOptional { state in
            if state.style.isSameKind(as: style) { state.routeWithResult } else { nil }
        }
    }

    fileprivate func sheetDismissalBehavior() -> Binding<SheetDismissalBehavior> {
        map { state in
            state?.style.sheetDismissalBehavior ?? .default
        }
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
