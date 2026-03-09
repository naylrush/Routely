import Routely
import SwiftUI

enum CreationRoute: Routable {
    case root
    case flow(CreationFlowRoute)
}

enum CreationFlowRoute: FlowRoutable {
    case form
    case details
    case confirm
}

extension CreationRoute: RoutableDestination {
    var body: some View {
        switch self {
        case .root: FlowRootView(initialRoute: CreationFlowRoute.form)
        case .flow(let route): route.body
        }
    }

    var wrapToRootView: Bool {
        switch self {
        case .root: false
        case let .flow(route): route.wrapToRootView
        }
    }
}

extension CreationFlowRoute: RoutableDestination {
    var body: some View {
        CreationFlowStepView(route: self)
    }
}

extension CreationFlowRoute: FlowRoutableDestination {
    var flowPresentationStyle: FlowPresentationStyle {
        switch self {
        case .form, .details: .push
        case .confirm: .present(.sheet())
        }
    }
}

extension CreationFlowRoute: Convertible {
    nonisolated init?(_ route: Route) {
        if case .creation(.flow(let flowRoute)) = route {
            self = flowRoute
        } else {
            return nil
        }
    }

    nonisolated func into() -> Target? {
        .creation(.flow(self))
    }
}

extension CreationFlowRoute {
    var stepNumber: Int {
        switch self {
        case .form: 1
        case .details: 2
        case .confirm: 3
        }
    }

    var showCloseButton: Bool { self == .form || self == .confirm }
    var isLast: Bool { self == .confirm }

    var stepTitle: String {
        switch self {
        case .form: "Create"
        case .details: "Details"
        case .confirm: "Confirm"
        }
    }

    var stepDescription: String {
        switch self {
        case .form: "Start with a name"
        case .details: "Add a short description"
        case .confirm: "Final sheet step"
        }
    }

    var buttonTitle: String {
        switch self {
        case .confirm: "Publish"
        default: "Next"
        }
    }

    var accentColor: Color {
        switch self {
        case .form: .orange
        case .details: .blue
        case .confirm: .green
        }
    }
}

// MARK: - View

private struct CreationFlowStepView: View {
    @Environment(\.next)
    private var next

    @Environment(\.finishWholeRoute)
    private var finishWholeRoute

    @Environment(\.dvijDismiss)
    private var dismiss

    let route: CreationFlowRoute

    private var accentColor: Color { route.accentColor }

    var body: some View {
        ZStack {
            accentColor
                .opacity(0.08)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Header

                Spacer()

                Progress

                Spacer()

                Actions
            }
            .padding(24)
        }
        .presentationDetents([.medium])
        .toolbar {
            if #available(iOS 26, *), route.showCloseButton {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
        .overlay(alignment: .topTrailing) {
            if #unavailable(iOS 26), route.showCloseButton {
                Button("Cancel") { dismiss() }
                    .font(.body)
                    .padding()
            }
        }
    }

    private var Header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Create Item")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)

            Text(route.stepTitle)
                .font(.largeTitle.weight(.bold))

            Text(route.stepDescription)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var Progress: some View {
        HStack(spacing: 12) {
            ForEach(1...3, id: \.self) { step in
                RoundedRectangle(cornerRadius: 4)
                    .fill(step <= route.stepNumber ? accentColor : Color(.systemGray5))
                    .frame(height: 4)
            }
        }
    }

    private var Actions: some View {
        VStack(spacing: 12) {
            ActionButton(title: route.buttonTitle) {
                if route.isLast {
                    finishWholeRoute(true)
                } else {
                    next()
                }
            }
        }
    }
}
