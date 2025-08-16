//
// Copyright © 2025 Движ
//

import Foundation

public enum PresentationStyle: Hashable, Sendable {
    case fullScreen
    case sheet(SheetDismissalBehavior = .default)
}

extension PresentationStyle {
    public func isSameKind(as other: PresentationStyle) -> Bool {
        switch (self, other) {
        case (.fullScreen, .fullScreen),
             (.sheet, .sheet): true
        default: false
        }
    }
}

extension PresentationStyle: CustomStringConvertible {
    public var description: String {
        switch self {
        case .fullScreen: "fullScreen"
        case let .sheet(behavior): "sheet(\(String(describing: behavior))"
        }
    }
}
