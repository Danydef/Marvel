//
//  CustomFont.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import UIKit

struct CustomFont {
    
    var fontType: FontType
    var size: Size
    var style: Style
    
    init(fontType: FontType,
         size: Size = .medium,
         style: Style = .regular) {
        
        self.fontType = fontType
        self.size = size
        self.style = style
    }
}

extension CustomFont {
    
    enum FontType {
        case system
    }
    
    enum Size: CGFloat {
        case ultraSmall = 8
        case extraSmall = 10
        case small = 12
        case medium = 14
        case large = 16
        case extraLarge = 20
        case ultraLarge = 24
    }
    
    enum Style {
        case regular
        case bold
        case light
    }
}

extension CustomFont {
    
        var uiFont: UIFont {
            switch self.fontType {
            case .system:
                return UIFont.systemFont(ofSize: self.size.rawValue)
            }
        }
}
