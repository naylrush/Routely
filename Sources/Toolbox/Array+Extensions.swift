//
// Copyright © 2025 Движ
//

import Foundation

extension Array {
    public func firstNonNil<T, E: Error>(
        _ transform: (Self.Element) throws(E) -> T?
    ) throws(E) -> T? {
        for element in self {
            if let result = try transform(element) {
                return result
            }
        }
        return nil
    }
}

extension Array where Element: Hashable {
    public func toSet() -> Set<Element> {
        Set(self)
    }
}

extension Array {
    private struct PairIterator: IteratorProtocol {
        let array: [Element]
        var i = 0
        var j = 1

        mutating func next() -> (Element, Element)? {
            guard i + 1 < array.count else { return nil }
            let result = (array[i], array[j])
            if j + 1 < array.count {
                j += 1
            } else {
                i += 1
                j = i + 1
            }
            return result
        }
    }

    public func uniquePairs() -> AnyIterator<(Element, Element)> {
        var iterator = PairIterator(array: self)
        return AnyIterator { iterator.next() }
    }
}
