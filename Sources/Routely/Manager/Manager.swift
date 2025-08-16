//
// Copyright © 2025 Движ
//

import SwiftUI

@MainActor
@Observable
final class Manager {
    static let shared = Manager()

    var topRouterId: UUID?
}
