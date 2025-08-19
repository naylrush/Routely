//
// Copyright © 2025 Движ
//

import Foundation

public protocol FlowRouteProtocol: ConvertibleRoutable, CaseIterable {}

public protocol FlowRouteDestinationProtocol: FlowRouteProtocol, ConvertibleRoutableDestination {
    var flowPresentationStyle: FlowPresentationStyle { get }
}

extension FlowRouteDestinationProtocol {
    public var flowPresentationStyle: FlowPresentationStyle { .push }
}
