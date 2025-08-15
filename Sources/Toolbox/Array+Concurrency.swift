//
// Copyright © 2025 Движ
//

import Foundation

extension Array where Element: Sendable {
    public func asyncForEach(_ body: @escaping @Sendable (Element) async -> Void) async {
        await withTaskGroup(of: Void.self) { group in
            for element in self {
                group.addTask {
                    await body(element)
                }
            }
        }
    }
}
