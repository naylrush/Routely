//
// Copyright © 2025 Движ
//

import Factory
import SwiftUI

struct StackSubviewConfigurationView<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        content
            // Removes title of back button
            .toolbarRole(.editor)
    }
}
