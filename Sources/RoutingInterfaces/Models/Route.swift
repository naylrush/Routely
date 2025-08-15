//
// Copyright © 2025 Движ
//

import SwiftUI

public enum Route: RouteProtocol {
    case safari(URL)

    #if DEBUG
    case _preview(PreviewRoute)
    #endif

    public var wrapToRootView: Bool {
        switch self {
        #if DEBUG
        case let ._preview(route): route.wrapToRootView
        #endif
        default: true
        }
    }
}
