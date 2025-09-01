//
//  DesignableView.swift
//  MediPatient
//
//  Created by Nick Joliya on 01/09/25.
//


import UIKit

// MARK: - UIView Styling
@IBDesignable
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set { layer.borderColor = newValue?.cgColor }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let cgColor = layer.shadowColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set { layer.shadowColor = newValue?.cgColor }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get { return layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
}

// MARK: - Custom Font for UILabel
extension UILabel {
    @IBInspectable var customFontName: String? {
        get { return self.font.fontName }
        set {
            guard let name = newValue, let size = self.font?.pointSize else { return }
            self.font = UIFont(name: name, size: size)
        }
    }
    
    @IBInspectable var customFontSize: CGFloat {
        get { return self.font.pointSize }
        set {
            self.font = self.font.withSize(newValue)
        }
    }
}

// MARK: - Custom Font for UIButton
extension UIButton {
    @IBInspectable var customFontName: String? {
        get { return self.titleLabel?.font.fontName }
        set {
            guard let name = newValue, let size = self.titleLabel?.font.pointSize else { return }
            self.titleLabel?.font = UIFont(name: name, size: size)
        }
    }
    
    @IBInspectable var customFontSize: CGFloat {
        get { return self.titleLabel?.font.pointSize ?? 17 }
        set {
            if let font = self.titleLabel?.font {
                self.titleLabel?.font = font.withSize(newValue)
            }
        }
    }
}

// MARK: - Custom Font for UITextField
extension UITextField {
    @IBInspectable var customFontName: String? {
        get { return self.font?.fontName }
        set {
            guard let name = newValue, let size = self.font?.pointSize else { return }
            self.font = UIFont(name: name, size: size)
        }
    }
    
    @IBInspectable var customFontSize: CGFloat {
        get { return self.font?.pointSize ?? 17 }
        set {
            if let font = self.font {
                self.font = font.withSize(newValue)
            }
        }
    }
}
