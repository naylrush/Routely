//
// Copyright © 2025 Движ
//

import SwiftUI

@MainActor
public protocol RouterProtocol<Route>: AnyObject, Sendable, Observable {
    associatedtype Route: RouteProtocol

    /// Pushes a new route onto the navigation path.
    func push(_ route: Route)

    /// Pops the last route from the navigation path.
    /// - Returns: A Boolean value indicating whether a route was successfully popped.
    @discardableResult
    func pop() -> Bool

    /// Pops all routes until the root is reached.
    func popToRoot()

    /// Presents a route with the specified presentation style and an optional completion closure.
    /// - Parameters:
    ///   - style: The presentation style to use.
    ///   - route: The destination route.
    ///   - completion: An optional closure executed after the presentation is complete.
    func present(
        style: PresentationStyle,
        _ route: Route,
        completion: (@MainActor () -> Void)?
    )

    /// Presents a route with a generic completion result.
    /// - Parameters:
    ///   - style: The presentation style to use.
    ///   - route: The destination route.
    ///   - completion: A closure that receives an optional generic result upon completion.
    func present<T>(
        style: PresentationStyle,
        _ route: Route,
        completion: @escaping @MainActor (T?) -> Void
    )

    /// Stops any ongoing presentation.
    /// - Returns: A Boolean value indicating whether there was an active presentation to stop.
    @discardableResult
    func stopPresenting() -> Bool

    /// Dismisses the current view by attempting various dismissal strategies.
    /// - Returns: A Boolean value indicating whether the dismissal was successful.
    @discardableResult
    func dismiss() -> Bool

    /// Calls an external dismissal action if available.
    /// - Returns: A Boolean value indicating whether an external dismiss action was executed.
    @discardableResult
    func externalRouterDismiss() -> Bool
}

extension RouterProtocol {
    public func present(
        style: PresentationStyle,
        _ route: Route,
        completion: (@MainActor () -> Void)? = nil
    ) {
        present(style: style, route, completion: nil)
    }
}
