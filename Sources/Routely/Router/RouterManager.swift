//
// Copyright © 2025 Движ
//

import SwiftUI

@MainActor
@Observable
final class RouterManager {
    static let shared = RouterManager()

    var topRouterId: UUID?
}
