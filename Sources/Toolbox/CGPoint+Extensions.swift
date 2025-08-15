//
// Copyright © 2025 Движ
//

import CoreGraphics

extension CGPoint {
    public var length: CGFloat {
        distance(to: .zero)
    }

    public static prefix func - (point: Self) -> Self {
        Self(x: -point.x, y: -point.y)
    }

    public static func += (lhs: inout Self, rhs: Self) {
        lhs.x += rhs.x
        lhs.y += rhs.y
    }

    public static func -= (lhs: inout Self, rhs: Self) {
        lhs += -rhs
    }

    public static func + (lhs: Self, rhs: Self) -> Self {
        var result = lhs
        result += rhs
        return result
    }

    public static func - (lhs: Self, rhs: Self) -> Self {
        lhs + -rhs
    }

    public static func *= (lhs: inout Self, rhs: CGFloat) {
        lhs.x *= rhs
        lhs.y *= rhs
    }

    public static func * (lhs: Self, rhs: CGFloat) -> Self {
        var result = lhs
        result *= rhs
        return result
    }

    public static func /= (lhs: inout Self, rhs: CGFloat) {
        lhs.x *= 1 / rhs
        lhs.y *= 1 / rhs
    }

    public func distanceSquared(to other: CGPoint) -> CGFloat {
        let diff = self - other
        let dx = diff.x
        let dy = diff.y

        return dx * dx + dy * dy
    }

    public func distance(to other: CGPoint) -> CGFloat {
        sqrt(distanceSquared(to: other))
    }

    public mutating func normalize() {
        self /= length
    }

    public func normalized() -> Self {
        var result = self
        result.normalize()
        return result
    }

    public mutating func bound(rect: CGRect) {
        x = x.bound(min: rect.minX, max: rect.maxX)
        y = y.bound(min: rect.minY, max: rect.maxY)
    }

    public func bounded(inRect rect: CGRect) -> Self {
        var result = self
        result.bound(rect: rect)
        return result
    }

    public static func generate(inRect rect: CGRect) -> Self {
        let x = CGFloat.random(in: rect.minX...rect.maxX)
        let y = CGFloat.random(in: rect.minY...rect.maxY)
        return CGPoint(x: x, y: y)
    }
}
