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

    public var diagonalLength: CGFloat {
        CGPoint(x: width, y: height).length
    }
}
