//
// Copyright © 2025 Движ
//

import Foundation

public struct RawDeepLink: Sendable, CustomStringConvertible {
    public let path: String

    public var description: String {
        path
    }

    public init(path: String) {
        self.path = path
    }
}
