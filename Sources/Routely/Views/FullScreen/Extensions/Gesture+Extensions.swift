//
// Copyright © 2025 Движ
//

import SwiftUI

extension Gesture {
    /// Workaround to detect gesture cancellation.
    ///
    /// When a DragGesture is active and a second finger tap occurs (for rotation, pinch, or long press),
    /// the dragging gesture will be cancelled.
    /// However, SwiftUI doesn't provide an API to handle this cancellation directly.
    /// The only available method in SwiftUI is the `updating` method,
    /// which resets the state on cancellation or ending without allowing custom handling.
    @MainActor
    public func onCancel(_ action: @escaping () -> Void) -> some Gesture {
        let longPressGesture = LongPressGesture(minimumDuration: 0, maximumDistance: 0)
            .onChanged { _ in
                action()
            }
            .onEnded { _ in
                action()
            }

        return exclusively(before: longPressGesture)
    }
}
