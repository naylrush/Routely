//
// Copyright © 2025 Движ
//

import RoutingInterfaces
import SwiftUI

struct DismissibleSheetContainer<Content: View>: UIViewControllerRepresentable {
    typealias ContentContainer = DismissibleSheetContentContainer<Content>
    typealias UIViewControllerType = PresentingHostingController<ContentContainer>
    typealias Coordinator = DismissibleSheetCoordinator

    // Captures the environment for the current hierarchy to propagate it to the content view.
    //
    // Avoid using context.environment because it contains information about the current state of nested views,
    // which may include environment values that have been modified compared to the original values.
    @Environment(\.self)
    private var environment

    @State private var showConfirmationAlert = false
    @State private var isGesturesEnabled = true

    @Binding var isPresented: Bool
    @Binding var behavior: SheetDismissalBehavior
    @ViewBuilder let content: () -> Content

    func makeUIViewController(context: Context) -> UIViewControllerType {
        UIViewControllerType()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        guard isPresented else {
            uiViewController.dismiss()
            return
        }

        let contentContainer = makeContentContainer()

        uiViewController.setGesturesEnabled(isGesturesEnabled)

        if uiViewController.isPresenting {
            uiViewController.update(rootView: contentContainer, delegate: context.coordinator)
        } else {
            uiViewController.present(rootView: contentContainer, delegate: context.coordinator)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator {
            behavior.isConfirmationRequired
        } onDidAttemptToDismiss: {
            showConfirmationAlert = true
        } onDismiss: {
            isPresented = false
        }
    }

    static func dismantleUIViewController(_ uiViewController: UIViewControllerType, coordinator: Coordinator) {
        uiViewController.cleanup()
    }

    private func makeContentContainer() -> ContentContainer {
        ContentContainer(
            confirmationDialogConfiguration: behavior.confirmationDialogConfiguration,
            showConfirmationAlert: $showConfirmationAlert,
            isGesturesEnabled: $isGesturesEnabled,
            environment: environment
        ) {
            isPresented = false
        } content: {
            content()
        }
    }
}

extension View {
    func dismissibleSheet<Content: View>(
        isPresented: Binding<Bool>,
        behavior: Binding<SheetDismissalBehavior>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        // This background is needed to:
        // 1. Layout itself to cover the entire screen.
        // 2. Layout the container below itself.
        // It should not handle touches to prevent overlapping interactions.
        background(
            DismissibleSheetContainer(
                isPresented: isPresented,
                behavior: behavior,
                content: content
            )
        )
    }
}

#Preview("Default behavior") {
    @Previewable @State var isPresented = false

    PreviewRootView<PreviewRoute, _> {
        Button("Show bottom sheet") {
            isPresented = true
        }
        .dismissibleSheet(
            isPresented: $isPresented,
            behavior: .constant(.default)
        ) {
            Text(Int.random(in: 0..<100).description)
        }
    }
}

#Preview("Requires confirmation behavior") {
    @Previewable @State var isPresented = false

    PreviewRootView<PreviewRoute, _> {
        Button("Show bottom sheet") {
            isPresented = true
        }
        .dismissibleSheet(
            isPresented: $isPresented,
            behavior: .constant(.requiresConfirmation(.init(confirmActionTitle: "Закрыть")))
        ) {
            Text("Content")
        }
    }
}
