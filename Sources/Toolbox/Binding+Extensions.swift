//
// Copyright © 2025 Движ
//

import SwiftUI

extension Binding where Value: Sendable {
    public func compacted<T>(fallback: T) -> Binding<T> where T? == Value {
        Binding<T>(
            get: { wrappedValue ?? fallback },
            set: { wrappedValue = $0 }
        )
    }
}
