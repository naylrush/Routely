//
// Copyright © 2025 Движ
//

import Foundation

@MainActor
public protocol DeepLinkingRegistrar {
    func registerInRegistry(_ registry: DeepLinkingRegistry)
}
