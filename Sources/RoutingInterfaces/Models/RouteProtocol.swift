//
// Copyright © 2025 Движ
//

import Foundation

public protocol RouteProtocol: Hashable, Sendable {
    var wrapToRootView: Bool { get }
}

extension RouteProtocol {
    public var wrapToRootView: Bool { true }
}
