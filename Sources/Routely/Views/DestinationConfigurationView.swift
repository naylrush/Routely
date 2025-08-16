//
// Copyright © 2025 Движ
//

import RoutelyInterfaces
import SwiftUI

struct DestinationConfigurationView<Destination: View>: View {
    @Environment(\.routingResult)
    private var routingResult

    let providedRoutelyResult: RoutelyResult?
    @ViewBuilder let destination: Destination

    var body: some View {
        destination
            .environment(\.routingResult, providedRoutelyResult ?? routingResult)
    }
}
