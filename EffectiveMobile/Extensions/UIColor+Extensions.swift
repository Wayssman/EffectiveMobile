//
//  UIColor+Extensions.swift
//  EffectiveMobile
//
//  Created by Alexandr on 06.12.2022.
//

import UIKit

enum EffectiveMobileColor {
    case orange
    case darkBlue
    
    // MARK: Properties
    var uiColor: UIColor {
        switch self {
        case .orange:
            return UIColor(netHex: 0xFF6E4E)
        case .darkBlue:
            return UIColor(netHex: 0x010035)
        }
    }
}

extension UIColor {
    static func effectiveMobile(_ color: EffectiveMobileColor) -> UIColor {
        return color.uiColor
    }
}

extension Optional where Wrapped == UIColor {
    static func effectiveMobile(_ color: EffectiveMobileColor) -> UIColor {
        return color.uiColor
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex: Int) {
        self.init(red: (netHex >> 16) & 0xff, green: (netHex >> 8) & 0xff, blue: netHex & 0xff)
    }
}
