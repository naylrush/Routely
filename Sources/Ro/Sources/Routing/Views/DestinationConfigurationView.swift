//
// Copyright © 2025 Движ
//

import RoutingInterfaces
import SwiftUI

struct DestinationConfigurationView<Destination: View>: View {
    @Environment(\.routingResult)
    private var routingResult

    let providedRoutingResult: RoutingResult?
    @ViewBuilder let destination: Destination

    var body: some View {
        destination
            .environment(\.routingResult, providedRoutingResult ?? routingResult)
    }
}
