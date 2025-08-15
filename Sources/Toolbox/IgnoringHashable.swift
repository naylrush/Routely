//
// Copyright © 2025 Движ
//

import Foundation

public struct IgnoringHashable<T> {
    public let wrapped: T

    public init(_ wrapped: T) {
        self.wrapped = wrapped
    }
}

extension IgnoringHashable: Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool { true }

    public func hash(into hasher: inout Hasher) {}
}

extension IgnoringHashable: Sendable where T: Sendable {}
