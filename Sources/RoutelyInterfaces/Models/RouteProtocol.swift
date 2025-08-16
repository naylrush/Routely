//
// Copyright © 2025 Движ
//

import Foundation
import SwiftUI

public protocol RouteProtocol: Hashable, Sendable {
    var wrapToRootView: Bool { get }
}

extension RouteProtocol {
    public var wrapToRootView: Bool { true }
}

public protocol RouteDestinationProtocol: RouteProtocol, View {
    typealias Destination = Body
}

extension RouteDestinationProtocol {
    public var destination: Destination { body }
}

public protocol ProxyRouteProtocol: RouteProtocol, Proxy where Base: RouteProtocol {}

public protocol ProxyRouteDestinationProtocol:
    RouteDestinationProtocol,
    ProxyRouteProtocol
where Base: RouteDestinationProtocol {}
