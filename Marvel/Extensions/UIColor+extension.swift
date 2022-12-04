//
//  UIColor+extension.swift
//  RickAndMorty
//
//  Created by Daniel Personal on 3/12/22.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    func image(_ size: CGSize = .zero) -> UIImage {
        UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
 
    class var primaryColor: UIColor {
        return #colorLiteral(red: 0.2039215686, green: 0.7647058824, blue: 0.7725490196, alpha: 1)
    }
    
    class var loginBackgroundColor: UIColor {
        return #colorLiteral(red: 0.07058823529, green: 0.1215686275, blue: 0.3333333333, alpha: 1)
    }
    class var loginPlaceHolderTextFieldColor: UIColor {
        return #colorLiteral(red: 0.4470588235, green: 0.4980392157, blue: 0.6470588235, alpha: 1)
    }
    
     // MARK: CardDetailsToday
    class var cardDetailsTodayBalanceBaseLineColor: UIColor {
        return #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
    }
    
    // MARK: TopBannerAlert
    class var topBannerAlertErrorColor: UIColor {
        return #colorLiteral(red: 1, green: 0.3098039216, blue: 0.3058823529, alpha: 1)
    }
    class var topBannerAlertWarningColor: UIColor {
        return #colorLiteral(red: 0.9294117647, green: 0.6588235294, blue: 0.2823529412, alpha: 1)
    }
    class var topBannerAlertSuccessColor: UIColor {
        return #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    }
    
    class var wizinkBlue: UIColor {
        return #colorLiteral(red: 0, green: 0.1490196078, blue: 0.4078431373, alpha: 1)
    }
    
    class var wizinkLightGrey: UIColor {
        return #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
    }
    
    class var wizinkSelectedGrey: UIColor {
        return #colorLiteral(red: 0.8823529412, green: 0.8823529412, blue: 0.8823529412, alpha: 1)
    }
    
    class var wizinkGray: UIColor {
        return #colorLiteral(red: 0.7960784314, green: 0.7960784314, blue: 0.7960784314, alpha: 1)
    }
    
    class var wizinkGreen: UIColor {
        return #colorLiteral(red: 0, green: 0.7764705882, blue: 0.7725490196, alpha: 1)
    }
    
    class var wizinkTextGrey: UIColor {
        return #colorLiteral(red: 0.3803921569, green: 0.3803921569, blue: 0.3803921569, alpha: 1)
    }
    
    class var wizinkTextDarkGrey: UIColor {
        return #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    }
    
    class var wizinkBluishGrey: UIColor {
        return #colorLiteral(red: 0.1882352941, green: 0.2274509804, blue: 0.2509803922, alpha: 1)
    }

    class var paymentMethodGrey: UIColor {
        return #colorLiteral(red: 0.9137254902, green: 0.9215686275, blue: 0.9254901961, alpha: 1)
    }

}
