//
// Copyright © 2025 Движ
//

import Foundation

public enum FlowPresentationStyle: Sendable, Hashable {
    case push
    case present(PresentationStyle)
}

extension FlowPresentationStyle: CustomStringConvertible {
    public var description: String {
        switch self {
        case .push: "push"
        case let .present(style): "present(\(style))"
        }
    }
}
