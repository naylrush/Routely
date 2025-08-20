//
// Copyright © 2025 Движ
//

import Observation
import OSLog
import SwiftUI

typealias CompositeRouterState<Route: Routable> = RouterState<CompositeRoute<Route>>

@Observable
class RouterState<Route: Routable> {
    var path: [IdentifiableModel<Route>]
    var presentationState: PresentationState<Route>? {
        willSet { _willSetPresentationState(presentationState) }
    }

    init(
        path: [IdentifiableModel<Route>] = [],
        presentationState: PresentationState<Route>? = nil
    ) {
        self.path = path
        self.presentationState = presentationState
    }
}

extension RouterState {
    private func _willSetPresentationState(_ oldValue: PresentationState<Route>?) {
        guard let oldValue else {
            return
        }

        guard let result = oldValue.routeWithResult.result else {
            logger.debug("Completing presentation without result")
            return
        }

        logger.debug("Completing presentation with result id: \(result.id)")

        Task { @MainActor in
            result.complete()
        }
    }
}

private let logger = Logger(subsystem: "Routely", category: "State")
