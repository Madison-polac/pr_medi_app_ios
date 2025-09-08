//
//  UIFont+Extension.swift
//  AllExtension
//
//  Created by Abhishek Yadav on 04/02/19.
//  Copyright © 2019 Prompt Softech. All rights reserved.
//

import UIKit

extension UIFont {
    
    public static var font_Name: String = "Myriad Pro" //"HelveticaNeue"
    
    public static func customFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        assert(font != nil, "Can't load font: \(name)")
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
    public static func mainFont(ofSize size: CGFloat) -> UIFont {
        return customFont(name: font_Name + "-CustomFont", size: size)
    }
    
    class func systemFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: font_Name, size: size)!
    }
    
    class func italicSystemFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: font_Name + "-Italic", size: size)!
    }
    
    public static func regularFont(_ size: CGFloat) -> UIFont
    {
        return UIFont(name: font_Name + "-Regular", size: size)!
    }
    public static func boldFont(_ size: CGFloat) -> UIFont
    {
        return UIFont(name: font_Name + "-Bold", size: size)!
    }
    public static func semiBoldFont(_ size: CGFloat) -> UIFont
    {
        return UIFont(name: font_Name + "-Semibold", size: size)!
    }
    public static func lightFont(_ size: CGFloat) -> UIFont
    {
        return UIFont(name: font_Name + "-Light", size: size)!
    }
    
    public static func calibriFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Calibri", size: size)!
    }
    
    public static func calibriFontBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Calibri-Bold", size: size)!
    }
    
    public static func normalFont(size: CGFloat) -> UIFont {
        if GlobalUtils.getInstance().getBundal() == BUNDLE_ID {
            return UIFont(name: "Avenir-Medium", size: size)!
        } else {
            return UIFont(name: "Calibri", size: size)!
        }
    }
    
    public static func navTitleFont(size: CGFloat) -> UIFont {
        if GlobalUtils.getInstance().getBundal() == BUNDLE_ID {
            return UIFont(name: "Avenir-Medium", size: size)!
        } else {
            return UIFont(name: "Calibri", size: size)!
        }
    }    
}


