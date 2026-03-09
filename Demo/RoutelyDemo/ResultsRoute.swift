import Routely
import SwiftUI

// MARK: - Result type

enum ThemeColor: String, Sendable, CaseIterable {
    case ocean = "Ocean"
    case forest = "Forest"
    case sunset = "Sunset"
    case berry = "Berry"

    var color: Color {
        switch self {
        case .ocean: .blue
        case .forest: .green
        case .sunset: .orange
        case .berry: .purple
        }
    }

    var icon: String {
        switch self {
        case .ocean: "drop.fill"
        case .forest: "leaf.fill"
        case .sunset: "sun.horizon.fill"
        case .berry: "circle.fill"
        }
    }
}

// MARK: - Route

enum ResultsRoute: Routable {
    case picker
    case confirm(ThemeColor)
    case quickSelect
}

extension ResultsRoute: Convertible {
    typealias Target = Route

    nonisolated init?(_ route: Target) {
        if case let .results(r) = route { self = r } else { return nil }
    }

    nonisolated func into() -> Target? { .results(self) }
}

extension ResultsRoute: RoutableDestination {
    var body: some View {
        switch self {
        case .picker: PickerView()
        case let .confirm(theme): ConfirmView(theme: theme)
        case .quickSelect: QuickSelectView()
        }
    }
}

// MARK: - Views

private struct PickerView: View {
    @Environment(RouterImpl.self)
    private var router

    @Environment(\.dvijDismiss)
    private var dismiss

    @Environment(\.finishWholeRoute)
    private var finishWholeRoute

    @State private var quickPickedTheme: ThemeColor?

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Header
                ThemeList
                    .padding(.bottom, 20)
                QuickSelectSection
                Spacer()
            }
        }
        .toolbar {
            if #available(iOS 26, *) {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
        .overlay(alignment: .topTrailing) {
            if #unavailable(iOS 26) {
                Button("Cancel") { dismiss() }
                    .font(.body)
                    .padding()
            }
        }
        .presentationDetents([.medium, .large])
    }

    private var Header: some View {
        VStack(spacing: 6) {
            Text("Pick a Theme")
                .font(.title2.weight(.bold))
            Text("Select one to continue")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.top, 32)
        .padding(.bottom, 28)
    }

    private var ThemeList: some View {
        VStack(spacing: 12) {
            ForEach(ThemeColor.allCases, id: \.self) { theme in
                Button {
                    router.push(.results(.confirm(theme)))
                } label: {
                    ThemeRow(theme: theme)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 20)
    }

    private var QuickSelectSection: some View {
        VStack(spacing: 10) {
            Button {
                router.present(style: .sheet(), .results(.quickSelect)) { (theme: ThemeColor?) in
                    quickPickedTheme = theme
                }
            } label: {
                ThemeRow(icon: "bolt.fill", color: .yellow, title: "Quick Select") {
                    if let theme = quickPickedTheme {
                        Circle()
                            .fill(theme.color)
                            .frame(width: 10, height: 10)
                    }
                }
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 20)

            if let theme = quickPickedTheme {
                ActionButton(title: "Complete with \(theme.rawValue)") {
                    finishWholeRoute(theme)
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

private struct ThemeRow<Trailing: View>: View {
    let icon: String
    let color: Color
    let title: String
    @ViewBuilder let trailing: Trailing

    init(
        theme: ThemeColor,
        @ViewBuilder trailing: () -> Trailing = { EmptyView() }
    ) {
        self.icon = theme.icon
        self.color = theme.color
        self.title = theme.rawValue
        self.trailing = trailing()
    }

    init(
        icon: String,
        color: Color,
        title: String,
        @ViewBuilder trailing: () -> Trailing = { EmptyView() }
    ) {
        self.icon = icon
        self.color = color
        self.title = title
        self.trailing = trailing()
    }

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 44, height: 44)
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundStyle(color)
            }
            Text(title)
                .font(.body.weight(.medium))
                .foregroundStyle(.primary)
            Spacer()
            trailing
            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

private struct QuickSelectView: View {
    @Environment(\.routingResult)
    private var routingResult

    @Environment(\.finishCurrentRoute)
    private var finishCurrentRoute

    @Environment(\.dvijDismiss)
    private var dismiss

    private let options: [ThemeColor] = [.ocean, .forest, .sunset]

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                VStack(spacing: 6) {
                    Text("Quick Select")
                        .font(.title2.weight(.bold))
                    Text("Pick one — closes this sheet, result saved below")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 32)
                .padding(.bottom, 28)

                VStack(spacing: 12) {
                    ForEach(options, id: \.self) { theme in
                        Button {
                            routingResult.value = theme
                            finishCurrentRoute()
                        } label: {
                            ThemeRow(theme: theme)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 20)

                Spacer()
            }
        }
        .toolbar {
            if #available(iOS 26, *) {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
        .overlay(alignment: .topTrailing) {
            if #unavailable(iOS 26) {
                Button("Cancel") { dismiss() }
                    .font(.body)
                    .padding()
            }
        }
        .presentationDetents([.medium])
    }
}

private struct ConfirmView: View {
    @Environment(\.finishWholeRoute)
    private var finishWholeRoute

    @Environment(\.dvijDismiss)
    private var dismiss

    let theme: ThemeColor

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            ThemePreview
            Spacer()
            Actions
        }
        .frame(maxWidth: .infinity)
        .background(theme.color.opacity(0.07).ignoresSafeArea())
        .navigationTitle("Confirm")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var ThemePreview: some View {
        VStack(spacing: 20) {
            ZStack {
                Circle()
                    .fill(theme.color.opacity(0.15))
                    .frame(width: 100, height: 100)
                Image(systemName: theme.icon)
                    .font(.system(size: 44))
                    .foregroundStyle(theme.color)
            }
            VStack(spacing: 8) {
                Text(theme.rawValue)
                    .font(.largeTitle.weight(.bold))
                Text("Apply this theme?")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private var Actions: some View {
        VStack(spacing: 12) {
            ActionButton(title: "Apply \(theme.rawValue)") {
                finishWholeRoute(theme)
            }
            Button("Go Back") { dismiss() }
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 32)
        .padding(.bottom, 40)
    }
}
