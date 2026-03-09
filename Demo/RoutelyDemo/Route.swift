import Routely
import SwiftUI

typealias RouterImpl = Router<Route>

enum Route: Routable {
    case stackDemo
    case stackDetail(Int)
    case creationDemo
    case creation(CreationRoute)
    case resultsDemo
    case results(ResultsRoute)
    case webDemo
    case web(URL)
}

extension Route: WebRoutable {
    init(url: URL) {
        self = .web(url)
    }
}

extension Route: RoutableDestination {
    var body: some View {
        switch self {
        case .stackDemo: StackDemoView()
        case let .stackDetail(level): StackDetailView(level: level)
        case .creationDemo: CreationDemoView()
        case let .creation(route): route.body
        case .resultsDemo: ResultsDemoView()
        case let .results(route): route.body
        case .webDemo: WebDemoView()
        case let .web(url): SafariView(url: url)
        }
    }

    var wrapToRootView: Bool {
        switch self {
        case let .creation(route): route.wrapToRootView
        case let .results(route): route.wrapToRootView
        default: true
        }
    }
}

// MARK: - Stack Demo

private struct StackDemoView: View {
    @Environment(RouterImpl.self)
    private var router

    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 8) {
                Text("Stack Navigation")
                    .font(.title.weight(.bold))
                Text("push / pop / popToRoot")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            ActionButton(title: "Push Level 1") {
                router.push(.stackDetail(1))
            }
        }
    }
}

private struct StackDetailView: View {
    @Environment(RouterImpl.self)
    private var router

    let level: Int

    private var levelColor: Color {
        let colors: [Color] = [.blue, .purple, .orange, .green]
        return colors[(level - 1) % colors.count].opacity(0.15)
    }

    var body: some View {
        ZStack {
            levelColor.ignoresSafeArea()

            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Text("Level \(level)")
                        .font(.largeTitle.weight(.bold))
                    Text((1...level).map { "\($0)" }.joined(separator: " → "))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .monospacedDigit()
                }

                VStack(spacing: 12) {
                    if level < 4 {
                        ActionButton(title: "Push Level \(level + 1)") {
                            router.push(.stackDetail(level + 1))
                        }
                    }

                    ActionButton(title: "Pop") {
                        router.pop()
                    }

                    ActionButton(title: "Pop to Root") {
                        router.popToRoot()
                    }
                }
            }
        }
    }
}

// MARK: - Creation Demo

private struct CreationDemoView: View {
    @Environment(RouterImpl.self)
    private var router

    @State private var successResult: Bool??

    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            VStack(spacing: 8) {
                Text("Create New Item")
                    .font(.title.weight(.bold))
                    .multilineTextAlignment(.center)
                Text("Flow-based wizard with sheet presentation")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            ActionButton(title: "Start Creation Flow") {
                let config = ConfirmationDialogConfiguration(
                    confirmActionTitle: "Discard"
                )
                router.present(
                    style: .sheet(.requiresConfirmation(config)),
                    .creation(.root)
                ) { (success: Bool?) in
                    successResult = success
                }
            }

            ResultText
        }
        .padding(.horizontal, 32)
    }

    @ViewBuilder private var ResultText: some View {
        switch successResult {
        case nil:
            Text("Result: Not finished yet")
                .font(.subheadline)
                .foregroundStyle(.tertiary)

        case .some(nil):
            HStack(spacing: 10) {
                Image(systemName: "xmark.circle")
                    .foregroundStyle(.secondary)
                Text("Result: Cancelled")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))

        case .some(.some(let success)):
            HStack(spacing: 10) {
                Image(systemName: success ? "checkmark.circle.fill" : "tray.and.arrow.down")
                    .foregroundStyle(success ? .green : .orange)
                Text(success ? "Result: Published" : "Result: Saved as draft")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

// MARK: - Results Demo

private struct ResultsDemoView: View {
    @Environment(RouterImpl.self)
    private var router

    @State private var selectedTheme: ThemeColor?
    @State private var wasCancelled = false

    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 8) {
                Text("Result Handling")
                    .font(.title.weight(.bold))
                Text("present(style:route:completion:)")
                    .font(.caption)
                    .fontDesign(.monospaced)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            ResultCard

            ActionButton(title: "Pick Theme") {
                router.present(
                    style: .sheet(),
                    .results(.picker)
                ) { (theme: ThemeColor?) in
                    if let theme {
                        selectedTheme = theme
                        wasCancelled = false
                    } else {
                        wasCancelled = true
                    }
                }
            }
        }
        .padding(.horizontal, 32)
    }

    @ViewBuilder private var ResultCard: some View {
        if let theme = selectedTheme {
            HStack(spacing: 14) {
                ZStack {
                    Circle()
                        .fill(theme.color.opacity(0.15))
                        .frame(width: 48, height: 48)
                    Image(systemName: theme.icon)
                        .font(.title2)
                        .foregroundStyle(theme.color)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("Applied Theme")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(theme.rawValue)
                        .font(.body.weight(.semibold))
                        .foregroundStyle(theme.color)
                }
                Spacer()
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.green)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(theme.color.opacity(0.06))
            .overlay {
                RoundedRectangle(cornerRadius: 14)
                    .stroke(theme.color.opacity(0.2), lineWidth: 1)
            }
            .clipShape(RoundedRectangle(cornerRadius: 14))
        } else {
            HStack(spacing: 12) {
                Image(systemName: wasCancelled ? "xmark.circle" : "circle.dashed")
                    .foregroundStyle(wasCancelled ? .secondary : .tertiary)
                Text(wasCancelled ? "Cancelled — result is nil" : "No theme selected yet")
                    .font(.subheadline)
                    .foregroundStyle(wasCancelled ? .secondary : .tertiary)
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
    }
}

// MARK: - Web Demo

private struct WebDemoView: View {
    @Environment(RouterImpl.self)
    private var router

    // swiftlint:disable:next force_unwrapping
    private let swiftUIDocsURL = URL(string: "https://developer.apple.com/documentation/swiftui")!

    var body: some View {
        VStack(spacing: 24) {
            Header

            VStack(spacing: 12) {
                ActionButton(title: "SwiftUI Documentation") {
                    router.present(
                        style: .sheet(),
                        .web(swiftUIDocsURL)
                    )
                }
            }
        }
        .padding(.horizontal, 32)
    }

    private var Header: some View {
        VStack(spacing: 8) {
            Text("Present Web")
                .font(.title.weight(.bold))
            Text("present(style: .sheet(), route:)")
                .font(.caption)
                .fontDesign(.monospaced)
                .foregroundStyle(.secondary)
        }
    }
}
