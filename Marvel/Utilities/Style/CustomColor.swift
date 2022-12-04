//
//  CustomColor.swift
//  Marvel
//
//  Created by Daniel Personal on 3/12/22.
//

import UIKit

enum CustomColor: String {
    case textHighlighted
    case textIcons
    case textLight
    case textNormal
    case textSecondary
    
    case viewContainer
    case viewGeneralBackground
    case viewIntermediary
    case viewMapArea
    case viewMapShadow
    case viewPrimary
    case viewSecondary
    case viewSeparator
}

extension CustomColor {
    var color: UIColor {
       
        var color: UIColor
        
        switch self {
        case .textHighlighted:
            color = #colorLiteral(red: 0, green: 0.1411764706, blue: 0.3254901961, alpha: 1)
        case .textIcons:
            color = #colorLiteral(red: 0.02352941176, green: 0.02352941176, blue: 0.02352941176, alpha: 1)
        case .textLight:
            color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .textNormal:
            color = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        case .textSecondary:
            color = #colorLiteral(red: 0.3725490196, green: 0.3725490196, blue: 0.3725490196, alpha: 1)
        case .viewContainer:
            color = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        case .viewGeneralBackground:
            color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .viewIntermediary:
            color = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        case .viewMapArea:
            color = #colorLiteral(red: 0.7647058824, green: 0.8941176471, blue: 0.9215686275, alpha: 0.7)
        case .viewMapShadow:
            color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.09)
        case .viewPrimary:
            color = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        case .viewSecondary:
            color = #colorLiteral(red: 0, green: 0.1411764706, blue: 0.3254901961, alpha: 1)
        case .viewSeparator:
            color = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }
        
        return UIColor(named: self.rawValue.capitalized) ?? color
    }
}
