//
// Copyright © 2025 Движ
//

import SwiftUI

extension View {
    nonisolated public func dvijSensoryFeedback(
        _ feedback: SensoryFeedback,
        trigger: Bool
    ) -> some View {
        sensoryFeedback(
            feedback,
            trigger: trigger,
            condition: { oldValue, newValue in
                !oldValue && newValue
            }
        )
    }

    nonisolated public func dvijRedacted(model: LoadingRedactionModel) -> some View {
        self
            .redacted(reason: model.reason)
            .disabled(model.isRedacted)
    }

    @inlinable
    nonisolated public func frame(size: CGSize, alignment: Alignment = .center) -> some View {
        frame(width: size.width, height: size.height, alignment: alignment)
    }

    @inlinable
    nonisolated public func frame(squareSide: CGFloat, alignment: Alignment = .center) -> some View {
        frame(width: squareSide, height: squareSide, alignment: alignment)
    }

    public func centredVertically() -> some View {
        VStack {
            Spacer()
            self
            Spacer()
        }
    }

    @inlinable
    nonisolated public func isHidden(_ isHidden: Bool) -> some View {
        opacity(isHidden ? 0 : 1)
    }
}

extension View {
    @inlinable
    public func onHeightChange(action: @escaping @MainActor (CGFloat) -> Void) -> some View {
        onGeometryChange(
            for: CGFloat.self,
            of: \.size.height,
            action: action
        )
    }
}

public struct LoadingRedactionModel {
    public let reason: RedactionReasons
    public let isError: Bool

    public var isRedacted: Bool {
        !isError && !reason.isEmpty
    }

    public init(reason: RedactionReasons = [], isError: Bool = false) {
        self.reason = reason
        self.isError = isError
    }
}
