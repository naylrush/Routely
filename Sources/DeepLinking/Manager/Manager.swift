//
// Copyright © 2025 Движ
//

import SwiftUI

@MainActor
public final class Manager {
    public static let shared = Manager()

    public var pendingRawDeepLink: RawDeepLink?
}
