import Routely
import SwiftUI

enum FlowRoute: FlowRoutable {
    case first
    case second
    case third
    case fourth
    case fifth
}

extension FlowRoute: RoutableDestination {
    var body: some View {
        switch self {
        case .first: FlowStepView(route: .first)
        case .second: FlowStepView(route: .second)
        case .third: FlowStepView(route: .third)
        case .fourth: FlowStepView(route: .fourth)
        case .fifth: FlowStepView(route: .fifth)
        }
    }
}

extension FlowRoute: Convertible {
    typealias Target = Route

    nonisolated init?(_ route: Target) {
        if case let .flow(flowRoute) = route { self = flowRoute } else { return nil }
    }

    nonisolated func into() -> Target? { .flow(self) }
}

extension FlowRoute: FlowRoutableDestination {
    var flowPresentationStyle: FlowPresentationStyle {
        switch self {
        case .first, .second, .fourth, .fifth: .push
        case .third: .present(.sheet())
        }
    }
}

extension FlowRoute {
    var stepNumber: Int {
        switch self {
        case .first: 1
        case .second: 2
        case .third: 3
        case .fourth: 4
        case .fifth: 5
        }
    }

    var isLast: Bool { self == .fifth }
    var isSheet: Bool { self == .third }
}

// MARK: - View

private struct FlowStepView: View {
    @Environment(RouterImpl.self)
    private var router

    @Environment(\.next)
    private var next

    @Environment(\.dvijDismiss)
    private var dismiss

    let route: FlowRoute

    private var stepColors: [Color] { [.blue, .purple, .pink, .orange, .green] }
    private var accentColor: Color { stepColors[route.stepNumber - 1] }

    var body: some View {
        ZStack {
            accentColor
                .opacity(0.08)
                .ignoresSafeArea()

            VStack(spacing: 12) {
                Text("Flow")
                    .font(.largeTitle.weight(.bold))

                HStack {
                    ZStack {
                        Circle()
                            .fill(accentColor.opacity(0.15))
                            .frame(width: 72, height: 72)
                        Text("\(route.stepNumber)")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(accentColor)
                    }

                    Text("of 5")
                        .font(.title2.weight(.semibold))
                }

                if route.isSheet {
                    Label("Presented as sheet", systemImage: "rectangle.bottomthird.inset.filled")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                ActionButton(title: route.isLast ? "Pop to Root" : "Next") {
                    route.isLast ? router.popToRoot() : next()
                }
            }
        }
        .toolbar {
            if #available(iOS 26, *), route.isSheet {
                ToolbarItem(placement: .topBarLeading) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
        .overlay(alignment: .topLeading) {
            if #unavailable(iOS 26), route.isSheet {
                DismissButton(action: dismiss)
            }
        }
    }
}

// MARK: - Shared

private struct DismissButton: View {
    let action: RoutelyAction<Void>

    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.white)
                .padding(8)
                .background(Circle().fill(Color.black.opacity(0.6)))
                .padding(12)
        }
    }
}
