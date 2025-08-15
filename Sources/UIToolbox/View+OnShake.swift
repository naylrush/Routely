//
// Copyright © 2025 Движ
//

// https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-shake-gestures
import SwiftUI
import UIKit

extension UIDevice {
    fileprivate static let didShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

extension UIWindow {
    // swiftlint:disable:next override_in_extension
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }

        NotificationCenter.default.post(name: UIDevice.didShakeNotification, object: nil)
    }
}

private struct DeviceDidShakeModifier: ViewModifier {
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.didShakeNotification)) { _ in
                action()
            }
    }
}

extension View {
    public func onShake(action: @escaping () -> Void) -> some View {
        modifier(DeviceDidShakeModifier(action: action))
    }
}
