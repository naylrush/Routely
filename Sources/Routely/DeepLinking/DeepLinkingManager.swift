//
// Copyright © 2025 Движ
//

import SwiftUI

@MainActor
public final class DeepLinkingManager {
    public static let shared = DeepLinkingManager()

    private var pendingRawDeepLink: RawDeepLink?

    func setPendingRawDeepLink(_ rawDeepLink: RawDeepLink) {
        pendingRawDeepLink = rawDeepLink
    }

    func getPendingRawDeepLink() -> RawDeepLink? {
        defer { pendingRawDeepLink = nil }
        return pendingRawDeepLink
    }
}
