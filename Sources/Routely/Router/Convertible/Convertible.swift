//
// Copyright © 2025 Движ
//

public protocol OptionalFrom<FromType> {
    associatedtype FromType

    init?(_: FromType)
}

public protocol Into<IntoType> {
    associatedtype IntoType

    func into() -> IntoType
}

public protocol Convertible<Target>: OptionalFrom, Into where IntoType == Target?, FromType == Target {
    associatedtype Target
}

public protocol SelfConvertible: Convertible where Target == Self {}

extension SelfConvertible {
    public init?(_ target: Self) {
        self = target
    }

    public func into() -> Self? {
        self
    }
}
