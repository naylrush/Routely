//
// Copyright © 2025 Движ
//

import Foundation

@MainActor
public protocol Registrar {
    func registerInRegistry(_ registry: Registry)
}
