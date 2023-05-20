//
//  ThemeColor.swift
//  Findit
//
//  Created by Ivan on 20/05/23.
//

import Foundation
import SwiftUI

struct Theme { private init() {} }

extension Theme {
    struct Colors {
        static let gray500 = Color("Gray500")
    }
}

extension Theme {
    struct FontSize {
        static let xlarage = Font.system(size: 72)
        static let xxlarge = Font.system(size: 96)
    }
}

extension Theme {
    struct CornerRadius {
        static let large: Double = 16
    }
}
