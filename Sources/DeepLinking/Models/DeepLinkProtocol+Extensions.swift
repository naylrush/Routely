//
// Copyright © 2025 Движ
//

import Foundation

extension DeepLinkProtocol {
    public var asDeepLink: URL? {
        let path = "\(Constants.baseDeepLink)/\(path)"
        return URL(string: path)
    }

    public var asUniversalLink: URL? {
        let path = "\(Constants.baseUrl)/\(path)"
        return URL(string: path)
    }
}

private enum Constants {
    static let baseDeepLink = "dvij://"
    static let baseUrl = "https://\(URLHost.dvij)"
}
