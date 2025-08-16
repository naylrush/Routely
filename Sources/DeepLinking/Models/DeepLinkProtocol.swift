//
// Copyright © 2025 Движ
//

import Foundation
import RoutelyInterfaces

public protocol DeepLinkProtocol: Sendable {
    associatedtype Route: RouteProtocol

    var path: String { get }
}
