//
// Copyright © 2025 Движ
//

import RoutingInterfaces
import SwiftUI

extension View {
    func fullScreen<Item: Sendable, Content: View>(
        item: Binding<Item?>,
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View {
        fullScreenCover(isPresented: item.isNotNil()) {
            if let item = item.wrappedValue {
                content(item)
            }
        }
    }

    func dismissibleSheet<Item: Sendable, Content: View>(
        item: Binding<Item?>,
        behavior: Binding<SheetDismissalBehavior>,
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View {
        dismissibleSheet(
            isPresented: item.isNotNil(),
            behavior: behavior
        ) {
            if let item = item.wrappedValue {
                content(item)
            }
        }
    }
}
