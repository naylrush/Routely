//
// Copyright © 2025 Движ
//

import Foundation

@MainActor
enum LinkParser {
    static func parseDeepLink(url: URL) -> RawDeepLink? {
        if let appDeepLink = parseAppDeepLink(url: url) {
            return appDeepLink
        }

        if let urlDeepLink = parseUniversalLink(url: url) {
            return urlDeepLink
        }

        return nil
    }

    static func parseAppDeepLink(url: URL) -> RawDeepLink? {
        guard url.scheme == DeepLinkingConfiguration.shared.appScheme else {
            return nil
        }
        let path = url.sanitizingPath()

        let pathWithHost = if let host = url.host() {
            "\(host)/\(path)"
        } else {
            path
        }
        return RawDeepLink(path: pathWithHost)
    }

    static func parseUniversalLink(url: URL) -> RawDeepLink? {
        guard
            url.isHttpsScheme,
            let host = url.host(),
            DeepLinkingConfiguration.shared.urlHosts.contains(host)
        else {
            return nil
        }

        let path = url.sanitizingPath()
        return RawDeepLink(path: path)
    }
}

extension URL {
    fileprivate var isHttpsScheme: Bool {
        scheme == "https"
    }
}
