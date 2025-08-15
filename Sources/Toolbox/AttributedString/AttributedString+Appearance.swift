//
// Copyright © 2025 Движ
//

import SwiftUI

extension AttributedString {
    public struct Appearance: Sendable {
        public let font: Font
        public let color: Color

        public init(
            font: Font,
            color: Color = .black
        ) {
            self.font = font
            self.color = color
        }
    }
}

extension AttributedString {
    public mutating func apply(appearance: Appearance) {
        self.font = appearance.font
        self.foregroundColor = appearance.color
    }

    public func applying(appearance: Appearance) -> AttributedString {
        var string = self
        string.apply(appearance: appearance)
        return string
    }

    public mutating func addLink(_ link: URL) {
        self.link = link
        self.underlineStyle = .single
    }
}
