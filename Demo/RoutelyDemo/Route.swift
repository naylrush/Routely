import Routely
import SwiftUI

typealias RouterImpl = Router<Route>

enum Route: Routable {
    case root
    case flowRoot
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
        case .root: ContentRootView()
        case .flowRoot: FlowRootView(initialRoute: FlowRoute.first)
        case let .flow(route): route.body
        case let .web(url): SafariView(url: url)
        }
    }
}

extension Route {
    var wrapToRootView: Bool {
        switch self {
        case .flowRoot: false
        default: true
        }
    }
}

private struct ContentRootView: View {
    @Environment(RouterImpl.self)
    private var router

    var body: some View {
        VStack(spacing: 24) {
            Text("https://example.com")

            ActionButton(title: "Present flow") {
                router.present(style: .fullScreen, .flowRoot)
            }
        }
    }
}
