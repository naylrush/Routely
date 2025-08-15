// swiftlint:disable:this file_name
//
// Copyright © 2025 Движ
//

import Foundation

extension Any? {
    public nonisolated nonmutating func `as`<T>(_ type: T.Type) -> T? {
        self as? T
    }
}
