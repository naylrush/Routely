//
// Copyright © 2025 Движ
//

import Foundation

extension String {
    public func toMarkdown() -> AttributedString {
        let prepared = convertingNewlinesForMarkdown()
        return (try? AttributedString(markdown: prepared)) ?? AttributedString(self)
    }

    private func convertingNewlinesForMarkdown() -> String {
        // Markdown doesn't parse '\n', so we need to replace it with the actual line separator character.
        // However, this replacement may cause incorrect styling, so we add a space, which doesn't affect the output.
        description.replacingOccurrences(of: "\n", with: " \(String.lineSeparator)")
    }
}
