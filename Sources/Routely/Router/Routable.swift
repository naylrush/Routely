//
// Copyright © 2025 Движ
//

import Foundation
import SwiftUI

public protocol Routable: Hashable, Sendable {}

public protocol RoutableDestination: Routable, View {
    var wrapToRootView: Bool { get }
}

extension RoutableDestination {
    public var wrapToRootView: Bool { true }
}
