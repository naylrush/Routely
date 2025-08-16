//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
import SwiftUI

extension EnhancedRoute:
    View,
    RouteDestinationProtocol,
    ProxyRouteDestinationProtocol
where Base: RouteDestinationProtocol {
    public var body: some View {
        switch self {
        case let .safari(url): SafariView(url: url)
        case let .wrapped(wrapped): wrapped.body
        }
    }
}
