//
//  FontExtention.swift
//  MediPatient
//
//  Created by Nick Joliya on 21/08/25.
//

//import UIKit
//
//extension UIFont {
//
//    static func ubuntuRegular(ofSize size: CGFloat) -> UIFont {
//        return UIFont(name: "Ubuntu-Regular", size: size) ??
//               UIFont.systemFont(ofSize: size)
//    }
//
//    static func ubuntuBold(ofSize size: CGFloat) -> UIFont {
//        return UIFont(name: "Ubuntu-Bold", size: size) ??
//               UIFont.boldSystemFont(ofSize: size)
//    }
//    static func ubuntuMedium(ofSize size: CGFloat) -> UIFont {
//        return UIFont(name: "Ubuntu-Medium", size: size) ??
//               UIFont.systemFont(ofSize: size)
//    }
//
//    static func ubuntuLight(ofSize size: CGFloat) -> UIFont {
//        return UIFont(name: "Ubuntu-Light", size: size) ??
//               UIFont.boldSystemFont(ofSize: size)
//    }
//   
//}
//
//
//
//@IBDesignable
//class FontLabel: UILabel {
//    
//    // MARK: - Font Type (Dropdown in Storyboard)
//    @IBInspectable var fontType: String = "regular" {
//        didSet { updateFont() }
//    }
//    
//    // MARK: - Custom Font Size (User types manually)
//    @IBInspectable var customSize: CGFloat = 14 {
//        didSet { updateFont() }
//    }
//    
//    private func updateFont() {
//        var fontName: String
//        
//        switch fontType.lowercased() {
//        case "medium": fontName = "Ubuntu-Medium"
//        case "bold": fontName = "Ubuntu-Bold"
//        case "light": fontName = "Ubuntu-Light"
//        default: fontName = "Ubuntu-Regular"
//        }
//        
//        self.font = UIFont(name: fontName, size: customSize) ?? UIFont.systemFont(ofSize: customSize)
//    }
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        updateFont()
//    }
//    
//    override func prepareForInterfaceBuilder() {
//        super.prepareForInterfaceBuilder()
//        updateFont()
//    }
//}
//
//
