//
// Copyright © 2025 Движ
//

import Foundation

extension Comparable {
    public func bound(min: Self, max: Self) -> Self {
        Swift.max(min, Swift.min(max, self))
    }
}
