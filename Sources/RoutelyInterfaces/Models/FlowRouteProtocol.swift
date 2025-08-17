//
// Copyright © 2025 Движ
//

import Foundation

public protocol FlowRouteProtocol: ProxyRouteProtocol, CaseIterable {}

public protocol FlowRouteDestinationProtocol: FlowRouteProtocol, ProxyRouteDestinationProtocol {
    var flowPresentationStyle: FlowPresentationStyle { get }
}

extension FlowRouteDestinationProtocol {
    public var flowPresentationStyle: FlowPresentationStyle { .push }
}
