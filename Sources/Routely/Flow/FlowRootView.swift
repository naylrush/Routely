//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
import SwiftUI

public struct FlowRootView<FlowRoute: FlowRouteDestinationProtocol>: View {
    private let initialRoute: FlowRoute

    public init(initialRoute: FlowRoute) {
        self.initialRoute = initialRoute
    }

    public var body: some View {
        RootView(route: ProxyFlowRoute(initialRoute))
    }
}

#if DEBUG
#Preview {
    FlowRootView(initialRoute: PreviewRoute.first)
}

public enum PreviewRoute {
    case first
    case second
    case third
    case fourth
    case fifth
}

extension PreviewRoute: FlowRouteDestinationProtocol {
    public var flowPresentationStyle: FlowPresentationStyle {
        switch self {
        case .first, .second, .fourth, .fifth: .push
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
        case .fifth: ContentView(route: .fifth)
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
                if case .present = route.flowPresentationStyle {
                    dismiss()
                }
                Task {
                    next()
                }
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
