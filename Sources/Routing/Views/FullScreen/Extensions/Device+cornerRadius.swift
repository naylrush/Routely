//
// Copyright © 2025 Движ
//

import DeviceKit
import UIKit

extension Device {
    // Info from https://www.screensizes.app
    var cornerRadius: CGFloat {
        switch self {
        case .iPhone16Pro, .iPhone16ProMax: 62

        case .iPhone16, .iPhone16Plus,
             .iPhone15, .iPhone15Plus, .iPhone15Pro, .iPhone15ProMax,
             .iPhone14Pro, .iPhone14ProMax: 55

        case .iPhone14Plus,
             .iPhone13ProMax,
             .iPhone12ProMax: 53

        case .iPhone16e,
             .iPhone14,
             .iPhone13, .iPhone13Pro,
             .iPhone12, .iPhone12Pro: 47

        case .iPhone13Mini,
             .iPhone12Mini: 44

        case .iPhone11,
             .iPhoneXR: 41

        case .iPhone11Pro, .iPhone11ProMax,
             .iPhoneXS, .iPhoneXSMax: 39

        case .iPhoneSE3,
             .iPhoneSE2: 0

        case let .simulator(device): device.cornerRadius

        default: 48
        }
    }
}
