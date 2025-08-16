//
// Copyright © 2025 Движ
//

import DeviceKit
import SwiftUI

public struct FullScreenWrappingView<Background: View, Content: View>: View {
    @Environment(\.offsetY)
    private var offsetY

    @Environment(\.isDragging)
    private var isDragging

    private var topCornerRadius: CGFloat {
        isDragging ? Device.current.cornerRadius : 0
    }

    private let background: Background
    private let content: Content

    public init(
        @ViewBuilder background: () -> Background = { EmptyView() },
        @ViewBuilder content: () -> Content
    ) {
        self.background = background()
        self.content = content()
    }

    public var body: some View {
        FullScreenContent
            .mask {
                Mask
            }
    }

    private var FullScreenContent: some View {
        ZStack(alignment: .top) {
            ZStack {
                Color.white

                background
            }
            .offset(y: offsetY)
            .ignoresSafeArea()

            content
                .offset(y: offsetY)
        }
    }

    private var Mask: some View {
        Color.white
            .clipShape(.rect(topLeadingRadius: topCornerRadius, topTrailingRadius: topCornerRadius))
            .offset(y: offsetY)
            .ignoresSafeArea()
    }
}

#Preview("Not dragging") {
    PreviewContentView()
        .background(.green, ignoresSafeAreaEdges: .all)
        .environment(\.offsetY, 0)
        .environment(\.isDragging, false)
}

#Preview("Dragging") {
    PreviewContentView()
        .background(.green, ignoresSafeAreaEdges: .all)
        .environment(\.offsetY, 50)
        .environment(\.isDragging, true)
}

#Preview("Dragging 2") {
    PreviewContentView()
        .background(.green, ignoresSafeAreaEdges: .all)
        .environment(\.offsetY, 100)
        .environment(\.isDragging, true)
}

#Preview("Interactive") {
    @Previewable @State var offsetY: CGFloat = 0

    PreviewContentView()
        .background(.green, ignoresSafeAreaEdges: .all)
        .environment(\.offsetY, offsetY)
        .environment(\.isDragging, true)
        .gesture(
            DragGesture()
                .onChanged { value in
                    offsetY = max(0, value.translation.height)
                }
        )
}

private struct PreviewContentView: View {
    var body: some View {
        FullScreenWrappingView {
            ZStack {
                Color.blue

                Image(systemName: "scribble.variable")
                    .resizable()
                    .scaledToFill()
            }
        } content: {
            Text("Content")
                .foregroundColor(.white)
        }
    }
}
