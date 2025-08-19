//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
import SwiftUI

extension EnhancedRoute:
    View,
    RouteDestinationProtocol,
    ProxyRouteDestinationProtocol
where Wrapped: RouteDestinationProtocol {
    public var body: some View {
        switch self {
        case let .safari(url): SafariView(url: url)
        case let .wrapped(wrapped): wrapped.body
        }
    }

    public var wrapToRootView: Bool {
        switch self {
        case let .wrapped(route): route.wrapToRootView
        case .safari: true
        }
    }
}
