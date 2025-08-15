//
// Copyright © 2025 Движ
//

import RoutingInterfaces
import SwiftUI

public struct FlowRootView<Route: RouteProtocol, FlowRoute: FlowRouteProtocol, Destination: View>: View {
    public typealias ExpandToRoute = (FlowRoute) -> Route
    public typealias ShrinkToFlowRoute = (Route) -> FlowRoute?
    public typealias DestinationBuilder = (Route) -> Destination

    private let initialRoute: FlowRoute
    private let expandToRoute: ExpandToRoute
    private let shrinkToFlowRoute: ShrinkToFlowRoute
    private let destination: DestinationBuilder

    public init(
        initialRoute: FlowRoute,
        expandToRoute: @escaping ExpandToRoute,
        shrinkToFlowRoute: @escaping ShrinkToFlowRoute,
        @ViewBuilder destination: @escaping DestinationBuilder
    ) {
        self.initialRoute = initialRoute
        self.expandToRoute = expandToRoute
        self.shrinkToFlowRoute = shrinkToFlowRoute
        self.destination = destination
    }

    public var body: some View {
        RootView { route in
            if let flowRoute = shrinkToFlowRoute(route) {
                WrapToFlow(route: flowRoute)
            } else {
                // Fallback to open any type of route (e.g. deep link)
                // Note: This and subsequent screens will not be connected to the flow until they are dismissed
                destination(route)
            }
        } content: {
            WrapToFlow(route: initialRoute)
        }
    }

    private func WrapToFlow(route: FlowRoute) -> some View {
        FlowContentWrapperView(
            route: route,
            expandToRoute: expandToRoute,
            destination: destination
        )
    }
}

#if DEBUG
#Preview {
    FlowRootView(
        initialRoute: PreviewRoute.first,
        expandToRoute: { $0 },
        shrinkToFlowRoute: { $0 },
        destination: destination
    )
}

@MainActor
@ViewBuilder
private func destination(route: PreviewRoute) -> some View {
    switch route {
    case .first: ContentView(route: .first)
    case .second: ContentView(route: .second)
    case .third: ContentView(route: .third)
    case .fourth: ContentView(route: .fourth)
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
