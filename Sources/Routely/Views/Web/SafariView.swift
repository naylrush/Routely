//
// Copyright © 2025 Движ
//

import SafariServices
import SwiftUI

public struct SafariView: UIViewControllerRepresentable {
    public typealias UIViewControllerType = SFSafariViewController
    public typealias Coordinator = SafariViewCoordinator

    @Environment(\.dvijDismiss)
    private var dismiss

    private let url: URL

    public init(url: URL) {
        self.url = url
    }

    public func makeUIViewController(context: Context) -> UIViewControllerType {
        let vc = SFSafariViewController(url: url)
        vc.delegate = context.coordinator
        return vc
    }

    public func updateUIViewController(
        _ uiViewController: UIViewControllerType,
        context: Context
    ) {
        uiViewController.delegate = context.coordinator
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator {
            dismiss()
        }
    }
}

public class SafariViewCoordinator: NSObject, SFSafariViewControllerDelegate {
    fileprivate typealias OnDismiss = () -> Void

    private let onDismiss: OnDismiss

    fileprivate init(onDismiss: @escaping OnDismiss) {
        self.onDismiss = onDismiss
    }

    @objc
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        onDismiss()
    }
}
