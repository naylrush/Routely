//
// Copyright © 2025 Движ
//

import Foundation

extension Collection {
    public subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

extension MutableCollection {
    public subscript(safe index: Index) -> Element? {
        get {
            indices.contains(index) ? self[index] : nil
        }

        set {
            guard let newValue, indices.contains(index) else { return }
            self[index] = newValue
        }
    }
}

extension Collection? {
    public var isEmptyOrNil: Bool {
        self?.isEmpty ?? true
    }
}

extension Collection {
    @inlinable
    public func firstNonNil<T>(transform: (Element) throws -> T?) rethrows -> T? {
        for element in self {
            if let result = try transform(element) {
                return result
            }
        }
        return nil
    }
}
