//
// Copyright © 2025 Движ
//

public protocol Proxy {
    associatedtype Base

    init?(_ base: Base)
    func toBase() -> Base?
}

extension Proxy where Base == Self {
    public init?(_ base: Base) {
        self = base
    }

    public func toBase() -> Base? {
        self
    }
}
