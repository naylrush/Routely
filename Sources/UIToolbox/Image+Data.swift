//
// Copyright © 2025 Движ
//

import SwiftUI
import UIKit

extension Image {
    public init?(data: Data) {
        guard let uiImage = UIImage(data: data) else {
            return nil
        }
        self.init(uiImage: uiImage)
    }
}
