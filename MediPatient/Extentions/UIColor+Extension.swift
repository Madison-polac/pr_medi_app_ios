//
//  UIColor+Extension.swift
//  AllExtension
//
//  Created by Abhishek Yadav on 25/01/19.
//  Copyright © 2019 Prompt Softech. All rights reserved.
//

import UIKit

public extension UIColor {
    
    // This is a function that takes a hex string and returns a UIColor.
    static func hexString (hex:String) -> UIColor {
        return self.hexString(hex: hex, alpha: 1.0)
    }
    
    // This is a function that takes a hex string + Alpha and returns a UIColor.
    static func hexString (hex:String, alpha:CGFloat) -> UIColor {
        var cString : String = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cString = cString.uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    // This is a function that returns random UIColor.
    static func randomColor() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
    
    static func appColor() -> UIColor {
        return UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
    }
    
    static func barColor() -> UIColor {
        if GlobalUtils.getInstance().getBundal() == BUNDLE_ID {
            return UIColor(red: 0.0/255.0, green: 44.0/255.0, blue: 77.0/255.0, alpha: 1.0)
        } else {
            return UIColor.hexString(hex: "#2CA2E6")
        }
    }
    
    static func buttonBackColor() -> UIColor {
        if GlobalUtils.getInstance().getBundal() == BUNDLE_ID {
            return UIColor(red: 17.0/255.0, green: 148.0/255.0, blue: 243.0/255.0, alpha: 1.0)
        } else {
            return UIColor.hexString(hex: "#2E6DA4")
        }
    }
    
    static var appBackColor: UIColor {
        return UIColor.hexString(hex: "#F3F3F3")
    }
    
    static var navTintColor: UIColor {
        return UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 249.0/255.0, alpha: 1.0)
    }
    
    static var tabTitleColor: UIColor {
        return UIColor(red: 48.0/255.0, green: 93.0/255.0, blue: 133.0/255.0, alpha: 1.0)
    }
    
    static var selectedTabColor: UIColor {
        return UIColor(red: 48.0/255.0, green: 93.0/255.0, blue: 133.0/255.0, alpha: 1.0)
    }
    
    static var themeColor: UIColor {
        if GlobalUtils.getInstance().getBundal() == BUNDLE_ID {
            return UIColor.hexString(hex: "#305D85")
        } else {
            return UIColor.hexString(hex: "#2CA2E6")
        }
    }
}
