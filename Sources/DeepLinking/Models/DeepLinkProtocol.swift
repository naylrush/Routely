//
// Copyright © 2025 Движ
//

import Foundation
import RoutelyInterfaces

public protocol DeepLinkProtocol: Sendable {
    associatedtype Route: Routable

    var path: String { get }
}
