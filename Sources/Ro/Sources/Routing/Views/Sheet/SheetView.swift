//
// Copyright © 2025 Движ
//

import SwiftUI

struct SheetView<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        content
    }
}
