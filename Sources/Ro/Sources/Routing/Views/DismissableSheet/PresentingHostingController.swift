//
// Copyright © 2025 Движ
//

import SwiftUI
import UIKit

final class PresentingHostingController<Content: View>: UIViewController {
    var isPresenting: Bool {
        hostingController != nil
    }

    private var hostingController: UIHostingController<Content>?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }

    func update(rootView: Content, delegate: UIAdaptivePresentationControllerDelegate) {
        guard let hostingController else { return }
        hostingController.rootView = rootView
        hostingController.presentationController?.delegate = delegate
    }

    func present(rootView: Content, delegate: UIAdaptivePresentationControllerDelegate) {
        guard !isPresenting else { return }

        // Recreate HostingController every presentation to erase previous state
        let newHostingController = makeHostingController(rootView: rootView)
        newHostingController.presentationController?.delegate = delegate
        hostingController = newHostingController

        Task { @MainActor [self] in
            present(newHostingController, animated: true)
        }
    }

    func dismiss() {
        guard isPresenting else { return }

        Task { @MainActor [self] in
            // Fixes multiple sheets dismissing from root
            dismissAllPresentedViewControllers(animated: true)
            cleanup()
        }
    }

    func cleanup() {
        hostingController?.removeFromParentAndCleanup()
        hostingController = nil
    }

    func setGesturesEnabled(_ isEnabled: Bool) {
        hostingController?.presentationController?.presentedView?.gestureRecognizers?.forEach { gesture in
            gesture.isEnabled = isEnabled
        }
    }
}

extension PresentingHostingController {
    private func makeHostingController(rootView: Content) -> UIHostingController<Content> {
        let hostingController = UIHostingController(rootView: rootView)
        hostingController.modalPresentationStyle = .pageSheet

        if let sheet = hostingController.presentationController as? UISheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = false
        }

        return hostingController
    }
}

extension UIViewController {
    fileprivate func dismissAllPresentedViewControllers(animated: Bool) {
        guard let presentedViewController else { return }
        presentedViewController.dismissAllPresentedViewControllers(animated: animated)
        presentedViewController.dismiss(animated: animated)
    }

    fileprivate func removeFromParentAndCleanup() {
        guard parent != nil else { return }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
