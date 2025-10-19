//
// Copyright © 2025 Движ
//

import Foundation

public protocol FlowRoutable: ConvertibleRoutable, CaseIterable {}

public protocol FlowRoutableDestination: FlowRoutable, ConvertibleRoutableDestination {
    var flowPresentationStyle: FlowPresentationStyle { get }
}

extension FlowRoutableDestination {
    public var flowPresentationStyle: FlowPresentationStyle { .push }
}

// WebRoutable
extension FlowRoutableDestination {
    public init?(url: URL) {
        nil
    }
}
