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
        case .first: DestinationView(route: .first)
        case .second: DestinationView(route: .second)
        case .third: DestinationView(route: .third)
        case .fourth: DestinationView(route: .fourth)
        case .fifth: DestinationView(route: .fifth)
        }
    }
}

extension FlowRoute: Convertible {
    typealias Target = Route

    nonisolated init?(_ route: Target) {
        if case let .flow(flowRoute) = route {
            self = flowRoute
        } else {
            return nil
        }
    }

    nonisolated func into() -> Target? {
        .flow(self)
    }
}

extension FlowRoute: FlowRoutableDestination {
    var flowPresentationStyle: FlowPresentationStyle {
        switch self {
        case .first, .second, .fourth, .fifth: .push
        case .third: .present(.sheet())
        }
    }
}

private struct DestinationView: View {
    @Environment(\.next)
    private var next

    @Environment(\.dvijDismiss)
    private var dismiss

    let route: FlowRoute

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 24) {
                Text(String(describing: route))

                ActionButton(title: "Next") {
                    next()
                }
            }
        }
        .overlay(alignment: .topLeading) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(8)
                    .background {
                        Circle().fill(Color.black.opacity(0.6))
                    }
                    .padding(12)
            }
        }
    }
}
