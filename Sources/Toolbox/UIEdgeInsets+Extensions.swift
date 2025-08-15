//
// Copyright © 2025 Движ
//

import Foundation
import UIKit

extension UIEdgeInsets {
    public init(all value: CGFloat) {
        self = .init(top: value, left: value, bottom: value, right: value)
    }

    public init(vertical: CGFloat = 0, horizontal: CGFloat = 0) {
        self = .init(
            top: vertical,
            left: horizontal,
            bottom: vertical,
            right: horizontal
        )
    }

    public var width: CGFloat {
        `left` + `right`
    }

    public var height: CGFloat {
        top + bottom
    }
}
