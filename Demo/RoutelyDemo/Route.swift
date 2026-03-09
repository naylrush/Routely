import Routely
import SwiftUI

typealias RouterImpl = Router<Route>

enum Route: Routable {
    case stackDemo
    case stackDetail(Int)
    case creationDemo
    case creation(CreationRoute)
    case flow(FlowRoute)
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
        case let .flow(route): route.body
        case let .web(url): SafariView(url: url)
        }
    }
}

extension Route {
    var wrapToRootView: Bool {
        switch self {
        case .flow: false
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

    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 8) {
                Text("Sheet + Navigation")
                    .font(.title.weight(.bold))
                    .multilineTextAlignment(.center)
                Text("sheet → push → push → sheet → publish")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            ActionButton(title: "Create New Item") {
                router.present(
                    style: .sheet(.requiresConfirmation(Appearance.exitConfirmation)),
                    .creation(.form)
                )
            }
        }
        .padding(.horizontal, 32)
    }
}

private enum Appearance {
    static let exitConfirmation = ConfirmationDialogConfiguration(
        confirmActionTitle: "Discard changes"
    )
}
