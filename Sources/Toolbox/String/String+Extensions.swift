//
// Copyright © 2025 Движ
//

import Foundation

extension String {
    public func hasSubsequence(_ subsequence: String) -> Bool {
        var subsequenceIterator = subsequence.makeIterator()
        var currentCharacter = subsequenceIterator.next()

        for character in self {
            // If we've matched all characters
            if currentCharacter == nil {
                return true
            }

            // If the current character matches the required character in the subsequence
            if character == currentCharacter {
                currentCharacter = subsequenceIterator.next()
            }
        }

        return currentCharacter == nil
    }

    public var lowercasedWithoutSpaces: String {
        lowercased().filter { !$0.isWhitespace }
    }
}

extension String? {
    public var isEmptyOrNil: Bool {
        self?.isEmpty ?? true
    }

    public var isNotEmptyOrNil: Bool {
        !isEmptyOrNil
    }
}
