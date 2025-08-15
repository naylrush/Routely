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

public protocol RouteDestinationProtocol: RouteProtocol, View {}

extension RouteDestinationProtocol {
    public typealias Destination = Body

    public var destination: Destination { body }
}
