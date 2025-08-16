//
// Copyright © 2025 Движ
//

import Foundation

public protocol FlowRouteProtocol: ProxyRouteProtocol, CaseIterable {
    var flowPresentationStyle: FlowPresentationStyle { get }
}

extension FlowRouteProtocol {
    public var flowPresentationStyle: FlowPresentationStyle { .push }
}

public protocol FlowRouteDestinationProtocol: FlowRouteProtocol, ProxyRouteDestinationProtocol {}
