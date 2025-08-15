//
// Copyright © 2025 Движ
//

import Foundation
import SwiftUI

public struct ConfirmationDialogConfiguration: Hashable, Sendable {
    public let title: String?
    public let confirmActionTitle: String

    public init(
        title: String? = nil,
        confirmActionTitle: String
    ) {
        self.title = title
        self.confirmActionTitle = confirmActionTitle
    }
}

extension View {
    nonisolated public func confirmationDialog(
        configuration: ConfirmationDialogConfiguration,
        isPresented: Binding<Bool>,
        onConfirmAction: @escaping () -> Void
    ) -> some View {
        confirmationDialog(
            configuration.title ?? "",
            isPresented: isPresented,
            titleVisibility: configuration.title == nil ? .hidden : .visible
        ) {
            Button(
                configuration.confirmActionTitle,
                role: .destructive,
                action: onConfirmAction
            )
        }
    }
}
