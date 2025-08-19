//
// Copyright © 2025 Движ
//

import Foundation
import SwiftUI

public protocol RouteProtocol: Hashable, Sendable {}

public protocol RouteDestinationProtocol: RouteProtocol, View {
    typealias Destination = Body

    var wrapToRootView: Bool { get }
}

extension RouteDestinationProtocol {
    public var destination: Destination { body }
    public var wrapToRootView: Bool { true }
}

public protocol ProxyRouteProtocol: RouteProtocol, Convertible where Target: RouteProtocol {}

public protocol ProxyRouteDestinationProtocol:
    RouteDestinationProtocol,
    ProxyRouteProtocol
where Target: RouteDestinationProtocol {}
