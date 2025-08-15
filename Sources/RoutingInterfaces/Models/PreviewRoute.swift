//
// Copyright © 2025 Движ
//

import Foundation
import SwiftUI
import Toolbox

#if DEBUG
public enum PreviewRoute: FlowRouteProtocol, CaseIterable {
    case first
    case second
    case third
    case fourth

    @ViewBuilder public var destination: some View {
        if DebugInfo.isInPreview {
            switch self {
            case .first: Text("First")
            case .second: Text("Second")
            case .third: Text("Third")
            case .fourth: Text("Fourth")
            }
        } else {
            fatalError("PreviewRoute should be used only for Previews")
        }
    }

    public var flowPresentationStyle: FlowPresentationStyle {
        switch self {
        case .first, .second, .fourth: .push
        case .third: .present(.sheet())
        }
    }
}
#endif
