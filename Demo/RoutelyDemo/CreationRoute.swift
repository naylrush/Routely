import Routely
import SwiftUI

enum CreationRoute: Routable {
    case form
    case details
    case settings
    case preview
}

extension CreationRoute: Convertible {
    typealias Target = Route

    nonisolated init?(_ route: Target) {
        if case let .creation(r) = route { self = r } else { return nil }
    }

    nonisolated func into() -> Target? { .creation(self) }
}

extension CreationRoute: RoutableDestination {
    var body: some View {
        switch self {
        case .form: CreationFormView()
        case .details: CreationDetailsView()
        case .settings: CreationSettingsView()
        case .preview: CreationPreviewView()
        }
    }
}

// MARK: - Views

private struct CreationFormView: View {
    @Environment(RouterImpl.self) private var router
    @Environment(\.dvijDismiss) private var dismiss

    var body: some View {
        CreationStepLayout(
            title: "New Item",
            subtitle: "Step 1 of 2 — Basic Info",
            buttonTitle: "Continue"
        ) {
            router.push(.creation(.details))
        }
        .navigationTitle("")
        .toolbar {
            if #available(iOS 26, *) {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
        .overlay(alignment: .topLeading) {
            if #unavailable(iOS 26) {
                DismissButton(action: dismiss)
            }
        }
    }
}

private struct CreationDetailsView: View {
    @Environment(RouterImpl.self) private var router

    var body: some View {
        CreationStepLayout(
            title: "Details",
            subtitle: "Step 2 of 2 — Details",
            buttonTitle: "Continue"
        ) {
            router.push(.creation(.settings))
        }
    }
}

private struct CreationSettingsView: View {
    @Environment(RouterImpl.self) private var router

    var body: some View {
        CreationStepLayout(
            title: "Settings",
            subtitle: "Final Step — Settings",
            buttonTitle: "Preview"
        ) {
            router.present(style: .sheet(), .creation(.preview))
        }
    }
}

private struct CreationStepLayout: View {
    let title: String
    let subtitle: String
    let buttonTitle: String
    let action: @MainActor () -> Void

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 32) {
                VStack(spacing: 8) {
                    Text(title)
                        .font(.largeTitle.weight(.bold))

                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                ActionButton(title: buttonTitle, action: action)
            }
        }
    }
}

private struct CreationPreviewView: View {
    @Environment(\.finishWholeRoute) private var finishWholeRoute
    @Environment(\.dvijDismiss) private var dismiss

    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 8) {
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 56))
                    .foregroundStyle(.blue)

                Text("Preview")
                    .font(.title.weight(.bold))

                Text("Ready to publish your item?")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            VStack(spacing: 12) {
                ActionButton(title: "Publish") {
                    finishWholeRoute(true)
                }

                Button("Edit") {
                    dismiss()
                }
                .foregroundStyle(.secondary)
            }
            .padding(.bottom, 32)
        }
        .frame(maxWidth: .infinity)
        .presentationDetents([.medium, .large])
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
