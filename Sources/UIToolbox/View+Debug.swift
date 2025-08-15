//
// Copyright © 2025 Движ
//

import SwiftUI

extension View {
    nonisolated public func strokeRandomColor() -> some View {
        overlay {
            Rectangle()
                .strokeBorder(Color.random, lineWidth: 2)
        }
    }
}
