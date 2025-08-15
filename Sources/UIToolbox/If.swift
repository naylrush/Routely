//
// Copyright © 2025 Движ
//

import SwiftUI

// swiftlint:disable:next type_name
public struct If<Content: View, ElseContent: View>: View {
    private let isContentVisible: Bool
    private let content: Content
    private let elseContent: ElseContent

    public init(
        _ isContentVisible: Bool,
        @ViewBuilder content: () -> Content,
        @ViewBuilder `else` elseContent: () -> ElseContent
    ) {
        self.isContentVisible = isContentVisible
        self.content = content()
        self.elseContent = elseContent()
    }

    public var body: some View {
        ZStack {
            content
                .isHidden(!isContentVisible)
            elseContent
                .isHidden(isContentVisible)
        }
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var isContentShown = true

    If(isContentShown) {
        List {
            ForEach(0..<5) { _ in
                Capsule()
                    .fill(Color.primary)
                    .frame(width: 300, height: 50)
            }
        }
    } `else`: {
        Text("Плейсхолдер")
    }
}
