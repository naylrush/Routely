//
// Copyright © 2025 Движ
//

import Foundation

public protocol ConvertibleRoutable: Routable, Convertible where Target: Routable {}

public protocol ConvertibleRoutableDestination:
    RoutableDestination,
    ConvertibleRoutable
where Target: RoutableDestination {}
