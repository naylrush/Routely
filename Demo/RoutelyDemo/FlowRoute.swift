import RoutelyInterfaces
import SwiftUI

public enum FlowRoute: FlowRouteProtocol {
    case first
    case second
    case third
    case fourth
    case fifth
}

extension FlowRoute: FlowRouteDestinationProtocol {
    public var body: some View {
        switch self {
        case .first: DestinationView(route: .first)
        case .second: DestinationView(route: .second)
        case .third: DestinationView(route: .third)
        case .fourth: DestinationView(route: .fourth)
        case .fifth: DestinationView(route: .fifth)
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
        VStack {
            Text(String(describing: route))

            Button {
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
