//
// Copyright © 2025 Движ
//

import Foundation

public struct IdentifiableModel<T>: Identifiable {
    public let id = UUID()
    public var value: T

    public init(value: T) {
        self.value = value
    }
}

extension IdentifiableModel: Equatable where T: Equatable {}
extension IdentifiableModel: Hashable where T: Hashable {}
