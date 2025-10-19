//
// Copyright © 2025 Движ
//

import Foundation
import SwiftUI

@MainActor
public protocol Routable: Hashable, Sendable {}

public protocol RoutableDestination: Routable, View {
    typealias Destination = Body

    var wrapToRootView: Bool { get }
}

extension RoutableDestination {
    public var destination: Destination { body }
    public var wrapToRootView: Bool { true }
}
