//
// Copyright © 2025 Движ
//

import Foundation

public enum SheetDismissalBehavior: Hashable, Sendable {
    case `default`
    case requiresConfirmation(ConfirmationDialogConfiguration)
}

extension SheetDismissalBehavior {
    public var isConfirmationRequired: Bool {
        if case .requiresConfirmation = self { true } else { false }
    }

    public var confirmationDialogConfiguration: ConfirmationDialogConfiguration? {
        if case .requiresConfirmation(let configuration) = self { configuration } else { nil }
    }
}
