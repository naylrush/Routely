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
        guard url.scheme == Configuration.shared.appScheme else {
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
        guard url.isHttpScheme, url.host() == Configuration.shared.urlHost else {
            return nil
        }
        let path = url.sanitizingPath()
        return RawDeepLink(path: path)
    }
}

extension URL {
    fileprivate var isHttpScheme: Bool {
        ["http", "https"].contains(scheme)
    }
}
