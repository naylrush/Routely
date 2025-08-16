//
// Copyright © 2025 Движ
//

public protocol From<FromType> {
    associatedtype FromType

    init(_: FromType)
}

public protocol Into<IntoType> {
    associatedtype IntoType

    func into() -> IntoType
}

public protocol OptionalFrom<FromType> {
    associatedtype FromType

    init?(_: FromType)
}

public typealias OptionalInto<IntoType> = Into<IntoType?>

public protocol Proxy {
    associatedtype Base

    init?(_ base: Base)
    func toBase() -> Base?
}

extension Proxy {
    public init?(_ base: Self) {
        self = base
    }

    public func toBase() -> Self? {
        self
    }
}
