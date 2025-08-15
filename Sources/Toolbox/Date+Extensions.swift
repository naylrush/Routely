//
// Copyright © 2025 Движ
//

import Foundation

extension Date {
    public var day: Int {
        component(.day)
    }

    public var hour: Int {
        component(.hour)
    }

    public var minute: Int {
        component(.minute)
    }

    public func component(_ component: Calendar.Component) -> Int {
        let dateComponents = Calendar.current.dateComponents([component], from: self)
        return dateComponents.value(for: component) ?? 0
    }

    public func boundHour(min: Int, max: Int) -> Self? {
        var components = Calendar.current.dateComponents(.upToMinute, from: self)

        let constrainedHour = hour.bound(
            min: min,
            max: minute == 0 ? max : max - 1
        )

        components.setValue(constrainedHour, for: .hour)

        return components.date
    }
}

extension Date {
    public var timestamp: Int {
        Int(timeIntervalSince1970)
    }
}

extension Set<Calendar.Component> {
    public static var upToMinute: Self {
        [.calendar, .timeZone, .year, .month, .day, .hour, .minute]
    }
}
