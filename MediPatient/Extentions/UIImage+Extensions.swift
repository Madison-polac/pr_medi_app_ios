import UIKit

extension UIImage {
    
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return self.jpegData(compressionQuality: jpegQuality.rawValue)
    }
    
    /// Resizes an image to the specified size.
    ///
    /// - Parameters:
    ///     - size: the size we desire to resize the image to.
    ///
    /// - Returns: the resized image.
    ///
    
    func filled(with color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.setFill()
        guard let context = UIGraphicsGetCurrentContext() else { return self }
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(CGBlendMode.normal)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        guard let mask = self.cgImage else { return self }
        context.clip(to: rect, mask: mask)
        context.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func imageWithSize(size: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale);
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height);
        draw(in: rect)
        
        let resultingImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return resultingImage
    }
    
    /// Resizes an image to the specified size and adds an extra transparent margin at all sides of
    /// the image.
    ///
    /// - Parameters:
    ///     - size: the size we desire to resize the image to.
    ///     - extraMargin: the extra transparent margin to add to all sides of the image.
    ///
    /// - Returns: the resized image.  The extra margin is added to the input image size.  So that
    ///         the final image's size will be equal to:
    ///         `CGSize(width: size.width + extraMargin * 2, height: size.height + extraMargin * 2)`
    ///
    func imageWithSize(size: CGSize, extraMargin: CGFloat) -> UIImage? {
        
        let imageSize = CGSize(width: size.width + extraMargin * 2, height: size.height + extraMargin * 2)
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale);
        let drawingRect = CGRect(x: extraMargin, y: extraMargin, width: size.width, height: size.height)
        draw(in: drawingRect)
        
        let resultingImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return resultingImage
    }
    
    /// Resizes an image to the specified size.
    ///
    /// - Parameters:
    ///     - size: the size we desire to resize the image to.
    ///     - roundedRadius: corner radius
    ///
    /// - Returns: the resized image with rounded corners.
    ///
    func imageWithSize(size: CGSize, roundedRadius radius: CGFloat) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        if let currentContext = UIGraphicsGetCurrentContext() {
            let rect = CGRect(origin: .zero, size: size)
            currentContext.addPath(UIBezierPath(roundedRect: rect,
                                                byRoundingCorners: .allCorners,
                                                cornerRadii: CGSize(width: radius, height: radius)).cgPath)
            currentContext.clip()
            
            //Don't use CGContextDrawImage, coordinate system origin in UIKit and Core Graphics are vertical oppsite.
            draw(in: rect)
            currentContext.drawPath(using: .fillStroke)
            let roundedCornerImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return roundedCornerImage
        }
        return nil
    }
    
/*
 *-*-*_*-*-*_*-*-*_*-*-*_*-*-*_*-*-*_*-*-*_*-*-*_*-*-*_*-*-*_*-*-*
 
 Image Constants: List of application images
 
 *-*-*_*-*-*_*-*-*_*-*-*_*-*-*_*-*-*_*-*-*_*-*-*_*-*-*_*-*-*_*-*-*
*/
    // App level
    public static var backArrow: UIImage { return UIImage(named: "back_icon")! }
    public static var show: UIImage { return UIImage(named: "Show_password")! }
    public static var hide: UIImage { return UIImage(named: "hide")! }
    public static var cancel: UIImage { return UIImage(named: "cancel")! }
    public static var markAll: UIImage { return UIImage(named: "mark-all")! }
    public static var unchecked: UIImage { return UIImage(named: "unchecked")! }
    public static var checked: UIImage { return UIImage(named: "checked")! }
    
    // Walkthrough
    public static var help1: UIImage { return UIImage(named: "help1")! }
    public static var help2: UIImage { return UIImage(named: "help2")! }
    public static var help3: UIImage { return UIImage(named: "help3")! }

    // Cultureboard
    public static var userImage: UIImage { return UIImage(named: "user_placeholder")! }
    public static var feedPlaceHolder: UIImage { return UIImage(named: "placeholder")! }
    public static var filter: UIImage { return UIImage(named: "filter")! }
    public static var addPost: UIImage { return UIImage(named: "addpost_icon")! }
    public static var send: UIImage { return UIImage(named: "send_icon")! }
    public static var like: UIImage { return UIImage(named: "like_icon")! }
    public static var disLike: UIImage { return UIImage(named: "unlike_icon")! }
    
    // Menu
    public static var menu: UIImage { return UIImage(named: "menu")! }
    public static var user: UIImage { return UIImage(named: "user")! }
    public static var cultureBoard: UIImage { return UIImage(named: "cultureboard")! }
    public static var employeePortal: UIImage { return UIImage(named: "employee_portal")! }
    public static var goals: UIImage { return UIImage(named: "goals")! }
    public static var settings: UIImage { return UIImage(named: "settings")! }
    public static var certificate: UIImage { return UIImage(named: "certificate")! }
    public static var logout: UIImage { return UIImage(named: "logout")! }
    public static var call: UIImage { return UIImage(named: "call")! }
    public static var play: UIImage { return UIImage(named: "play_icon")! }
    
    // Employee portal
    public static var hoursAndWages: UIImage { return UIImage(named: "hoursandwages")! }
    public static var directDeposit: UIImage { return UIImage(named: "direct-deposit")! }
    public static var tax: UIImage { return UIImage(named: "tax")! }
    public static var benefits: UIImage { return UIImage(named: "benefits")! }
    public static var pto: UIImage { return UIImage(named: "pto")! }
    public static var growth: UIImage { return UIImage(named: "growth")! }
    public static var fsa: UIImage { return UIImage(named: "fsa")! }
    public static var fourZeroOneK: UIImage { return UIImage(named: "401(k)")! }
    public static var finance: UIImage { return UIImage(named: "finance")! }
    public static var workerComp: UIImage { return UIImage(named: "worker-camp")! }
    public static var document: UIImage { return UIImage(named: "document")! }
    public static var referBusiness: UIImage { return UIImage(named: "refer-business")! }
    public static var medical: UIImage { return UIImage(named: "Medical_icon")! }
    public static var dental: UIImage { return UIImage(named: "Dental-icon")! }
    public static var vision: UIImage { return UIImage(named: "Vision-icon")! }
    public static var pdf: UIImage { return UIImage(named: "pdf_icon")! }
    public static var circle: UIImage { return UIImage(named: "circle-icon")! }
    public static var radio: UIImage { return UIImage(named: "radio_icon")! }
    
    // Goals and Scorecards
    public static var employees: UIImage { return UIImage(named: "employees")! }
    public static var more: UIImage { return UIImage(named: "more_icon")! }
    public static var upChart: UIImage { return UIImage(named: "up-chart")! }
    public static var maintainChart: UIImage { return UIImage(named: "maintain-chart")! }
    public static var downChart: UIImage { return UIImage(named: "down-chart")! }
    public static var plus: UIImage { return UIImage(named: "plus")! }
    public static var minus: UIImage { return UIImage(named: "minus")! }
    public static var rightArrow: UIImage { return UIImage(named: "arrow_right")! }
    public static var bottomArrow: UIImage { return UIImage(named: "arrow_bottom")! }
    public static var trendUpArrow: UIImage { return UIImage(named: "trend_up_new")! }
    public static var trendDownArrow: UIImage { return UIImage(named: "trend_down_new")! }
    public static var trendMaintain: UIImage { return UIImage(named: "trend_maintain")! }
    public static var trendUp: UIImage { return UIImage(named: "trend_up")! }
    public static var trendDown: UIImage { return UIImage(named: "trend_down")! }
    
    // StratusHR
    public static var radioOn: UIImage { return UIImage(named: "radio_icon")! }
    public static var radioOff: UIImage { return UIImage(named: "circle-icon")! }
    public static var checkMark: UIImage { return UIImage(named: "check-mark")! }
    public static var square: UIImage { return UIImage(named: "square")! }
}
