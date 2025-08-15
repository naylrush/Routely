//
// Copyright © 2025 Движ
//

import Foundation

public protocol FlowRouteProtocol: RouteProtocol, CaseIterable {
    var flowPresentationStyle: FlowPresentationStyle { get }
}

extension FlowRouteProtocol {
    public var flowPresentationStyle: FlowPresentationStyle { .push }
}
