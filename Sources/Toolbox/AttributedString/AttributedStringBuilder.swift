//
// Copyright © 2025 Движ
//

import SwiftUI

public enum AttributedStringBuilder {
    public static func build(
        appearance: AttributedString.Appearance,
        text: String,
        link: URL? = nil
    ) -> AttributedString {
        var string = AttributedString(text)
        string.apply(appearance: appearance)
        if let link {
            string.addLink(link)
        }
        return string
    }
}
