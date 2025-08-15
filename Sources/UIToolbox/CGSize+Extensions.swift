//
// Copyright © 2025 Движ
//

import Foundation
import UIKit

extension CGSize {
    public var integral: CGSize {
        CGSize(
            width: width.rounded(.up),
            height: height.rounded(.up)
        )
    }

    public func constrainSides(maxValue: CGFloat) -> CGSize {
        CGSize(
            width: min(maxValue, width),
            height: min(maxValue, height)
        )
    }

    public init(_ point: CGPoint) {
        self.init(width: point.x, height: point.y)
    }

    public init(square: CGFloat) {
        self.init(width: square, height: square)
    }
}

extension CGSize {
    public static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }

    public static prefix func - (value: CGSize) -> CGSize {
        CGSize(width: -value.width, height: -value.height)
    }

    public static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
        lhs + (-rhs)
    }
}
