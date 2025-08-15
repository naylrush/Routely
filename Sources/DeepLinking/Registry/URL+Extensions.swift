//
// Copyright © 2025 Движ
//

import Foundation

extension URL {
    public func sanitizingPath() -> String {
        let path = path()

        return path.first == "/"
        ? String(path.dropFirst())
        : path
    }

    public func sanitizingPathComponents() -> [String] {
        pathComponents.first == "/"
        ? Array(pathComponents.dropFirst())
        : pathComponents
    }
}

extension URL: @retroactive Identifiable {
    public var id: String { absoluteString }
}
