//
// Copyright © 2025 Движ
//

import SwiftUI

extension Binding where Value: Sendable {
    public func isNil<T>() -> Binding<Bool> where T? == Value {
        Binding<Bool>(
            get: { wrappedValue == nil },
            set: { setNil in
                if setNil {
                    wrappedValue = nil
                }
            }
        )
    }

    public func isNotNil<T>() -> Binding<Bool> where T? == Value {
        not(isNil())
    }
}

private func not(_ base: Binding<Bool>) -> Binding<Bool> {
    Binding(
        get: { !base.wrappedValue },
        set: { base.wrappedValue = !$0 }
    )
}
