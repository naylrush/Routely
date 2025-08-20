//
// Copyright © 2025 Движ
//

import SwiftUI

@MainActor
public final class DeepLinkingManager {
    public static let shared = DeepLinkingManager()

    public var pendingRawDeepLink: RawDeepLink?
}
