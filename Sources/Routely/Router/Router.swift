//
// Copyright © 2025 Движ
//

import Observation
import OSLog
import SwiftUI

@Observable
public class Router<Route: Routable>: Routing {
    nonisolated public var id: UUID { _id }
    nonisolated private let _id = UUID()

    var state = RouterState<Route>() {
        willSet { _willSetPresentationState(state.presentationState) }
    }

    @ObservationIgnored var onExternalRouterDismiss: (() -> Void)?

    private let shouldLogInit: Bool

    init(shouldLogInit: Bool = true) {
        self.shouldLogInit = shouldLogInit
        if shouldLogInit {
            log("init")
        }
    }

    deinit {
        if shouldLogInit {
            log("deinit")
        }
    }

    public func push(_ route: Route) {
        log("Pushing \(String(describing: route))")
        state.path.append(IdentifiableModel(value: route))
    }

    @discardableResult
    public func pop() -> Bool {
        guard !state.path.isEmpty else {
            return false
        }
        log("Popping")
        state.path.removeLast()
        return true
    }

    public func popToRoot() {
        log("Popping to root")
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
        let result = RoutelyResult { (value: T?, _) in
            completion(value)
        }
        present(style: style, route, result: result)
    }

    public func present<T>(
        style: PresentationStyle,
        _ route: Route,
        completion: @escaping @MainActor (T?, RoutelyResult.Params?) -> Void
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

        log(
            "Presenting \(style) \(String(describing: route)), routing result id: \(result?.id.uuidString ?? "nil")"
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
        log("Stopping presenting \(presentationState.style) \(String(describing: route))")
        state.presentationState = nil
        return true
    }

    @discardableResult
    public func dismiss() -> Bool {
        if stopPresenting() {
            log("Dismiss action stopped presenting")
            return true
        }

        if pop() {
            log("Dismiss action popped")
            return true
        }

        if externalRouterDismiss() {
            log("Dismiss action called back on external router")
            return true
        }

        log("Dismiss action did nothing")
        return false
    }

    @discardableResult
    public func externalRouterDismiss() -> Bool {
        guard let onExternalRouterDismiss else {
            log(level: .error, "External router dismiss is not provided")
            return false
        }
        log("Calling dismiss action on external router")
        onExternalRouterDismiss()
        return true
    }

    nonisolated private func log(level: OSLogType = .debug, _ message: String) {
        logger.log(level: level, "[\(self.id)] \(message)")
    }
}

extension Router {
    private func _willSetPresentationState(_ oldValue: PresentationState<Route>?) {
        guard let oldValue else {
            return
        }

        guard let result = oldValue.routeWithResult.result else {
            log("Completing presentation without result")
            return
        }

        Task { @MainActor in
            result.complete()
        }
    }
}

private let logger = Logger(subsystem: "Routely", category: "Router")
