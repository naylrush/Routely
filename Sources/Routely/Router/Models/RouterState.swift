//
// Copyright © 2025 Движ
//

import SwiftUI

struct RouterState<Route: Routable> {
    var path: [IdentifiableModel<Route>] = []
    var presentationState: PresentationState<Route>?
}
