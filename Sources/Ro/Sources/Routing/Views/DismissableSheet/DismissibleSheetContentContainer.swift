//
// Copyright © 2025 Движ
//

import SwiftUI
import UIToolbox

struct DismissibleSheetContentContainer<Content: View>: View {
    let confirmationDialogConfiguration: ConfirmationDialogConfiguration?
    @Binding var showConfirmationAlert: Bool
    @Binding var isGesturesEnabled: Bool
    let environment: EnvironmentValues

    let onConfirmAction: () -> Void
    @ViewBuilder let content: Content

    var body: some View {
        content
            .confirmationDialog(
                configuration: confirmationDialogConfiguration ?? .init(confirmActionTitle: "Закрыть"),
                isPresented: $showConfirmationAlert,
                onConfirmAction: onConfirmAction
            )
            .environment(\.self, environment)
            .onPreferenceChange(DismissibleSheetIsGesturesEnabled.self) { isEnabled in
                self.isGesturesEnabled = isEnabled ?? true
            }
    }
}
