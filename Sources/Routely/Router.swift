//
// Copyright © 2025 Движ
//

import Observation
import OSLog
import RoutelyInterfaces
import SwiftUI

@Observable
public class Router<Route: RouteProtocol>: RouterProtocol {
    let id = UUID()

    var state = RouterState<Route>()

    @ObservationIgnored var onExternalRouterDismiss: (() -> Void)?

    init() {}

    public func push(_ route: Route) {
        logger.debug("Pushing \(String(describing: route))")
        state.path.append(IdentifiableModel(value: route))
    }

    @discardableResult
    public func pop() -> Bool {
        guard !state.path.isEmpty else {
            return false
        }
        logger.debug("Popping")
        state.path.removeLast()
        return true
    }

    public func popToRoot() {
        logger.debug("Popping to route")
        state.path.removeLast(state.path.count)
    }

    public func present(
        style: PresentationStyle,
        _ route: Route,
        completion: (@MainActor () -> Void)? = nil
    ) {
        if let completion {
            present(style: style, route) { (_: Void?) in
                completion()
            }
        } else {
            present(style: style, route, result: nil)
        }
    }

    public func present<T>(
        style: PresentationStyle,
        _ route: Route,
        completion: @escaping @MainActor (T?) -> Void
    ) {
        let result = RoutelyResult(completion: completion)
        present(style: style, route, result: result)
    }

    private func present(
        style: PresentationStyle,
        _ route: Route,
        result: RoutelyResult?
    ) {
        stopPresenting()

        logger.debug(
            "Presenting \(style) \(String(describing: route)), routing result id: \(String(describing: result?.id))"
        )

        state.presentationState = PresentationState(
            style: style,
            routeWithResult: .init(route: route, result: result)
        )
    }

    @discardableResult
    public func stopPresenting() -> Bool {
        guard let presentationState = state.presentationState else {
            return false
        }
        let route = presentationState.routeWithResult.route
        logger.debug("Stopping presenting \(presentationState.style) \(String(describing: route))")
        state.presentationState = nil
        return true
    }

    @discardableResult
    public func dismiss() -> Bool {
        if stopPresenting() {
            logger.debug("Dismiss action stopped presenting")
            return true
        }

        if pop() {
            logger.debug("Dismiss action popped")
            return true
        }

        if externalRouterDismiss() {
            logger.debug("Dismiss action called back on external router")
            return true
        }

        logger.debug("Dismiss action did nothing")
        return false
    }

    @discardableResult
    public func externalRouterDismiss() -> Bool {
        guard let onExternalRouterDismiss else {
            logger.warning("External router dismiss is not provided")
            return false
        }
        logger.debug("Calling dismiss action on external router")
        onExternalRouterDismiss()
        return true
    }
}

private let logger = Logger(subsystem: "Routely", category: "Router")
