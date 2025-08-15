//
// Copyright © 2025 Движ
//

import SwiftUI

extension EdgeInsets {
    public init(
        leading: CGFloat,
        bottom: CGFloat,
        trailing: CGFloat
    ) {
        self.init(top: 0, leading: leading, bottom: bottom, trailing: trailing)
    }
    public init(
        top: CGFloat,
        bottom: CGFloat,
        trailing: CGFloat
    ) {
        self.init(top: top, leading: 0, bottom: bottom, trailing: trailing)
    }
    public init(
        top: CGFloat,
        leading: CGFloat,
        trailing: CGFloat
    ) {
        self.init(top: top, leading: leading, bottom: 0, trailing: trailing)
    }
    public init(
        top: CGFloat,
        leading: CGFloat,
        bottom: CGFloat
    ) {
        self.init(top: top, leading: leading, bottom: bottom, trailing: 0)
    }

    public init(
        top: CGFloat,
        leading: CGFloat
    ) {
        self.init(top: top, leading: leading, bottom: 0, trailing: 0)
    }
    public init(
        top: CGFloat,
        bottom: CGFloat
    ) {
        self.init(top: top, leading: 0, bottom: bottom, trailing: 0)
    }
    public init(
        top: CGFloat,
        trailing: CGFloat
    ) {
        self.init(top: top, leading: 0, bottom: 0, trailing: trailing)
    }
    public init(
        leading: CGFloat,
        bottom: CGFloat
    ) {
        self.init(top: 0, leading: leading, bottom: bottom, trailing: 0)
    }
    public init(
        leading: CGFloat,
        trailing: CGFloat
    ) {
        self.init(top: 0, leading: leading, bottom: 0, trailing: trailing)
    }
    public init(
        bottom: CGFloat,
        trailing: CGFloat
    ) {
        self.init(top: 0, leading: 0, bottom: bottom, trailing: trailing)
    }

    public init(top: CGFloat) {
        self.init(top: top, leading: 0, bottom: 0, trailing: 0)
    }
    public init(leading: CGFloat) {
        self.init(top: 0, leading: leading, bottom: 0, trailing: 0)
    }
    public init(bottom: CGFloat) {
        self.init(top: 0, leading: 0, bottom: bottom, trailing: 0)
    }
    public init(trailing: CGFloat) {
        self.init(top: 0, leading: 0, bottom: 0, trailing: trailing)
    }

    public init(all: CGFloat = 0) {
        self.init(top: all, leading: all, bottom: all, trailing: all)
    }

    public init(
        vertical: CGFloat = 0,
        horizontal: CGFloat = 0
    ) {
        self.init(
            top: vertical,
            leading: horizontal,
            bottom: vertical,
            trailing: horizontal
        )
    }
}
