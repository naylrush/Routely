//
// Copyright © 2025 Движ
//

import SwiftUI

extension CompositeRoute:
    View,
    RoutableDestination,
    ConvertibleRoutableDestination
where Wrapped: RoutableDestination {
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
