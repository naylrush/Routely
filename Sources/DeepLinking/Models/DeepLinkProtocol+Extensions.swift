//
// Copyright © 2025 Движ
//

import Foundation

extension DeepLinkProtocol {
    @MainActor public var asDeepLink: URL? {
        let path = "\(Configuration.shared.appScheme)://\(path)"
        return URL(string: path)
    }

    @MainActor public var asUniversalLink: URL? {
        let path = "\(Configuration.shared.httpScheme)://\(Configuration.shared.urlHost)/\(path)"
        return URL(string: path)
    }
}
