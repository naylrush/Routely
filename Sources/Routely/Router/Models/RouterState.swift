//
// Copyright © 2025 Движ
//

import SwiftUI

typealias CompositeRouterState<Route: Routable> = RouterState<CompositeRoute<Route>>

struct RouterState<Route: Routable> {
    var path: [IdentifiableModel<Route>] = []
    var presentationState: PresentationState<Route>?
}
