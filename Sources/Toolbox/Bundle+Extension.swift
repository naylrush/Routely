//
// Copyright © 2025 Движ
//

import Foundation

extension Bundle {
    public var version: String? {
        infoDictionary?["CFBundleShortVersionString"] as? String
    }

    public var buildVersion: String? {
        infoDictionary?["CFBundleVersion"] as? String
    }
}
