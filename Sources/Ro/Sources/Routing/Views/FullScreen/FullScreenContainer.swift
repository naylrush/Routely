//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
import SwiftUI
import UIToolbox

struct FullScreenContainer<Content: View>: View {
    // Два поля, чтобы во время анимации движения вверх при недостаточном скролле углы продолжали скругляться
    @State private var offsetY: CGFloat = 0
    @State private var isDragging = false

    @Environment(\.dvijDismiss)
    private var dismiss

    @ViewBuilder let content: Content

    var body: some View {
        content
            .presentationBackground {
                Appearance.presentationBackgroundColor
            }
            .environment(\.offsetY, offsetY)
            .environment(\.isDragging, isDragging)
            .gesture(swipeToDismissGesture)
    }

    private var swipeToDismissGesture: some Gesture {
        DragGesture()
            .onChanged { gestureValue in
                onChanged(gestureValue.translation.height)
            }
            .onEnded { gestureValue in
                onEnded(gestureValue.translation.height)
            }
            .onCancel {
                offsetY = 0
            }
    }

    private func onChanged(_ newOffsetY: CGFloat) {
        offsetY = max(0, newOffsetY)
        isDragging = offsetY > 0
    }

    private func onEnded(_ newOffsetY: CGFloat) {
        if newOffsetY >= Constants.minOffsetYToDismiss {
            dismiss()
            return
        }

        withAnimation(.interactiveSpring) {
            offsetY = 0
        } completion: {
            isDragging = false
        }
    }
}

private enum Constants {
    static let minOffsetYToDismiss: CGFloat = 150
}

private enum Appearance {
    static let presentationBackgroundColor = Color.clear
}

// MARK: - Preview

#Preview {
    @Previewable @State var isPresented = false

    ZStack {
        Color.green
            .ignoresSafeArea()

        Button("Show Full Screen") {
            isPresented = true
        }
    }
    .fullScreenCover(isPresented: $isPresented) {
        FullScreenContainer {
            PreviewContentView()
        }
        .environment(\.dvijDismiss, RoutelyAction { isPresented = false })
    }
}

#Preview("Content") {
    PreviewContentView()
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
