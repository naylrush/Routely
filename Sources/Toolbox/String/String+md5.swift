//
// Copyright © 2025 Движ
//

import CryptoKit
import Foundation

extension String {
    public var md5AsUInt: UInt { Data(utf8).md5AsUInt }
}

extension Data {
    var md5AsUInt: UInt {
        UInt(truncatingIfNeeded: md5First8BytesAsUInt64)
    }

    private var md5: Data {
        let buffer = Insecure.MD5.hash(data: self)
        return Data(buffer)
    }

    private var md5First8BytesAsUInt64: UInt64 {
        let slice = md5.prefix(8)
        return slice.withUnsafeBytes { $0.load(as: UInt64.self).bigEndian }
    }
}
