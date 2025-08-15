//
// Copyright © 2025 Движ
//

import RoutingInterfaces
import SwiftUI

public struct FlowRootView<
    Route: RouteDestinationProtocol,
    FlowRoute: FlowRouteProtocol
>: View {
    public typealias ExpandToRoute = (FlowRoute) -> Route
    public typealias ShrinkToFlowRoute = (Route) -> FlowRoute?

    private let initialRoute: FlowRoute
    private let expandToRoute: ExpandToRoute
    private let shrinkToFlowRoute: ShrinkToFlowRoute

    public init(
        initialRoute: FlowRoute,
        expandToRoute: @escaping ExpandToRoute,
        shrinkToFlowRoute: @escaping ShrinkToFlowRoute,
    ) {
        self.initialRoute = initialRoute
        self.expandToRoute = expandToRoute
        self.shrinkToFlowRoute = shrinkToFlowRoute
    }

    public var body: some View {
        RootView<Route, _>
//            if let flowRoute = shrinkToFlowRoute(route) {
//                WrapToFlow(route: flowRoute)
//            } else {
//                // Fallback to open any type of route (e.g. deep link)
//                // Note: This and subsequent screens will not be connected to the flow until they are dismissed
//                route.destination
//            }
        {
            WrapToFlow(route: initialRoute)
        }
    }

    private func WrapToFlow(route: FlowRoute) -> some View {
        FlowContentWrapperView(
            route: route,
            expandToRoute: expandToRoute,
        )
    }
}

#if DEBUG
#Preview {
    FlowRootView(
        initialRoute: PreviewRoute.first,
        expandToRoute: { $0 },
        shrinkToFlowRoute: { $0 },
    )
}

public enum PreviewRoute {
    case first
    case second
    case third
    case fourth
}

extension PreviewRoute: FlowRouteProtocol {
    public var flowPresentationStyle: FlowPresentationStyle {
        switch self {
        case .first, .second, .fourth: .push
        case .third: .present(.sheet())
        }
    }
}

extension PreviewRoute: RouteDestinationProtocol {
    public var body: some View {
        switch self {
        case .first: ContentView(route: .first)
        case .second: ContentView(route: .second)
        case .third: ContentView(route: .third)
        case .fourth: ContentView(route: .fourth)
        }
    }
}

private struct ContentView: View {
    @Environment(\.next)
    private var next

    @Environment(\.dvijDismiss)
    private var dismiss

    let route: PreviewRoute

    var body: some View {
        VStack {
            Text(String(describing: route))

            Button {
                if route == .third {
                    dismiss()
                }
                next()
            } label: {
                Text("Push Next")
                    .foregroundStyle(.black)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.blue)
                    }
            }
        }
    }
}
#endif
