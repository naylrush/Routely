//
// Copyright © 2025 Движ
//

import Foundation

public protocol DeepLink: Sendable {
    associatedtype Route: Routable

    var path: String { get }
}
