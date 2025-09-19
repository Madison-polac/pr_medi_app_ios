import UIKit

// MARK: - UIFont Helpers
extension UIFont {
    static func ubuntuRegular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Ubuntu-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    static func ubuntuBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Ubuntu-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
    static func ubuntuMedium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Ubuntu-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    static func ubuntuLight(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Ubuntu-Light", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

// MARK: - IBDesignable Font Label
@IBDesignable
class FontLabel: UILabel {
    @IBInspectable var fontType: String = "regular" {
        didSet { updateFont() }
    }
    @IBInspectable var customSize: CGFloat = 14 {
        didSet { updateFont() }
    }
    
    private func updateFont() {
        let fontName: String
        switch fontType.lowercased() {
        case "medium": fontName = "Ubuntu-Medium"
        case "bold":   fontName = "Ubuntu-Bold"
        case "light":  fontName = "Ubuntu-Light"
        default:       fontName = "Ubuntu-Regular"
        }
        self.font = UIFont(name: fontName, size: customSize) ?? UIFont.systemFont(ofSize: customSize)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateFont()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateFont()
    }
}

// MARK: - UIView Styling
@IBDesignable
extension UIView {
    
    // Corner + Border
    @IBInspectable var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue; layer.masksToBounds = newValue > 0 }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get { layer.borderColor.map(UIColor.init(cgColor:)) }
        set { layer.borderColor = newValue?.cgColor }
    }
    
    // Shadow
    @IBInspectable var shadowColor: UIColor? {
        get { layer.shadowColor.map(UIColor.init(cgColor:)) }
        set { layer.shadowColor = newValue?.cgColor }
    }
    @IBInspectable var shadowOpacity: Float {
        get { layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }
    @IBInspectable var shadowOffset: CGSize {
        get { layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }
    @IBInspectable var shadowRadius: CGFloat {
        get { layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
    
    func applyShadow(
        color: UIColor = UIColor.black.withAlphaComponent(0.1),
        opacity: Float = 1.0,
        radius: CGFloat = 6,
        offset: CGSize = CGSize(width: 0, height: 4)
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.masksToBounds = false
    }
    
    func dropShadow () {
        self.dropShadow(color: UIColor.appBackColor)
    }
    
    func dropShadow(color: UIColor) {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 4)  // positive y → bottom
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 0.1                          // subtle
        self.layer.shadowRadius = 3                             // blur
    }
    
    // Gradient
    func applyTopRightGradient(primaryColor: UIColor, cornerRadius: CGFloat = 12) {
        layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        layoutIfNeeded()
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint   = CGPoint(x: 0.7, y: 0.5)
        gradient.colors     = [primaryColor.cgColor, UIColor.white.cgColor]
        gradient.locations  = [0.0, 0.8]
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        gradient.mask = maskLayer
        
        layer.insertSublayer(gradient, at: 0)
    }
    
    // Corner rounding
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

// MARK: - UIView Utilities
extension UIView {
    var size: CGSize {
        get { frame.size }
        set { frame.size = newValue }
    }
    var width: CGFloat {
        get { frame.size.width }
        set { frame.size.width = newValue }
    }
    var height: CGFloat {
        get { frame.size.height }
        set { frame.size.height = newValue }
    }
    
    func subViews<T: UIView>(of type: T.Type) -> [T] {
        return subviews.compactMap { $0 as? T }
    }
    
    func allSubViewsOf<T: UIView>(type: T.Type) -> [T] {
        var all = [T]()
        func getSubviews(from view: UIView) {
            if let v = view as? T { all.append(v) }
            view.subviews.forEach { getSubviews(from: $0) }
        }
        getSubviews(from: self)
        return all
    }
}
