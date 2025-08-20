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

    let urlHost: String
    let httpScheme: String
    let appScheme: String

    public init(
        urlHost: String,
        httpScheme: String = "https",
        appScheme: String
    ) {
        self.urlHost = urlHost
        self.httpScheme = httpScheme
        self.appScheme = appScheme
    }
}
