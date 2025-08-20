//
// Copyright © 2025 Движ
//

import Foundation

extension DeepLink {
    @MainActor public var asDeepLink: URL? {
        let path = "\(DeepLinkingConfiguration.shared.appScheme)://\(path)"
        return URL(string: path)
    }

    @MainActor public var asUniversalLink: URL? {
        let path = "\(DeepLinkingConfiguration.shared.httpScheme)://\(DeepLinkingConfiguration.shared.urlHost)/\(path)"
        return URL(string: path)
    }
}
