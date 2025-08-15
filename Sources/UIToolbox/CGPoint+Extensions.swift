//
// Copyright © 2025 Движ
//

import UIKit

extension CGPoint {
    public static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    public static prefix func - (value: CGPoint) -> CGPoint {
        CGPoint(x: -value.x, y: -value.y)
    }

    public static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        lhs + (-rhs)
    }
}
