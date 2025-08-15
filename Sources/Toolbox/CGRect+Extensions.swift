//
// Copyright © 2025 Движ
//

import Foundation
import UIKit

extension CGRect {
    public func shrinked(insets: UIEdgeInsets) -> Self {
        Self(
            x: minX + insets.right,
            y: minY + insets.top,
            width: width - insets.width,
            height: height - insets.height
        )
    }

    public func shrinked(value: CGFloat) -> Self {
        shrinked(insets: UIEdgeInsets(all: value))
    }

    public static func circle(center: CGPoint, radius: CGFloat) -> Self {
        CGRect(
            x: center.x - radius,
            y: center.y - radius,
            width: radius * 2,
            height: radius * 2
        )
    }

    public func addingY(_ y: CGFloat) -> CGRect {
        CGRect(
            x: minX,
            y: minY + y,
            width: width,
            height: height
        )
    }
}
