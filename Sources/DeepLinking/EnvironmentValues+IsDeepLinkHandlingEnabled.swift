//
// Copyright © 2025 Движ
//

import SwiftUI

extension EnvironmentValues {
    @Entry public var isDeepLinkHandlingEnabled = true
}

extension View {
    public func deepLinkHandlingEnabled(_ isEnabled: Bool) -> some View {
        environment(\.isDeepLinkHandlingEnabled, isEnabled)
    }
}
