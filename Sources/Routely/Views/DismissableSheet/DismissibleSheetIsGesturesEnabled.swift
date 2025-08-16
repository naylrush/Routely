//
// Copyright © 2025 Движ
//

import Foundation
import SwiftUI

public struct DismissibleSheetIsGesturesEnabled: PreferenceKey {
    public static let defaultValue: Bool? = nil

    public static func reduce(value: inout Bool?, nextValue: () -> Bool?) {
        guard let next = nextValue() else { return }
        value = next
    }
}
