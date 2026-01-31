//
// Copyright © 2025 Движ
//

import Foundation

@MainActor
public struct DeepLinkingConfiguration {
    public static var shared: Self! {
        didSet { isEnabled = true }
    }

    public private(set) static var isEnabled = false

    var mainUrlHost: String {
        urlHosts[0]
    }

    let appScheme: String
    let urlHosts: [String]

    public init(
        appScheme: String,
        urlHosts: [String]
    ) {
        self.appScheme = appScheme
        self.urlHosts = urlHosts
    }
}
