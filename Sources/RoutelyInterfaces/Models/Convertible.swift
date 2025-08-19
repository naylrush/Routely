//
// Copyright © 2025 Движ
//

public protocol Convertible {
    associatedtype Target

    init?(_: Target)
    func into() -> Target?
}

public protocol SelfConvertible: Convertible where Target == Self {}

extension SelfConvertible {
    public init?(_ target: Target) {
        self = target
    }

    public func into() -> Target? {
        self
    }
}
