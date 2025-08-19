//
// Copyright © 2025 Движ
//

import UIKit

final class DismissibleSheetCoordinator: NSObject, UIAdaptivePresentationControllerDelegate {
    typealias OnDismissConfirmationEnabled = () -> Bool
    typealias OnDidAttemptToDismiss = () -> Void
    typealias OnDismiss = () -> Void

    private let onDismissConfirmationEnabled: OnDismissConfirmationEnabled
    private let onDidAttemptToDismiss: OnDidAttemptToDismiss
    private let onDismiss: OnDismiss

    init(
        onDismissConfirmationEnabled: @escaping OnDismissConfirmationEnabled,
        onDidAttemptToDismiss: @escaping OnDidAttemptToDismiss,
        onDismiss: @escaping OnDismiss
    ) {
        self.onDismissConfirmationEnabled = onDismissConfirmationEnabled
        self.onDidAttemptToDismiss = onDidAttemptToDismiss
        self.onDismiss = onDismiss
    }

    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        !onDismissConfirmationEnabled()
    }

    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        onDidAttemptToDismiss()
    }

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        onDismiss()
    }
}
