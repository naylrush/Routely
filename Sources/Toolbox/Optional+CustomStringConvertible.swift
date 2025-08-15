//
// Copyright © 2025 Движ
//

import Foundation

extension Optional: @retroactive CustomStringConvertible where Wrapped: CustomStringConvertible {
    public var description: String {
        self?.description ?? "nil"
    }
}
