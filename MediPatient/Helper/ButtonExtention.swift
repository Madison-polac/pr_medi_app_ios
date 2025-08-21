//
//  ButtonExtention.swift
//  MediPatient
//
//  Created by Nick Joliya on 11/08/25.
//

import UIKit

extension UIButton {
    
    /// Underlines the button title text
    func underlineTitle(color: UIColor? = nil) {
        guard let title = self.title(for: .normal) else { return }
        
        let attributedString = NSAttributedString(
            string: title,
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: color ?? self.titleColor(for: .normal) ?? UIColor.link
            ]
        )
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
    /// Adds a bottom border line to the button
    func addBottomBorderLine(color: UIColor = .systemBlue, height: CGFloat = 2) {
        let bottomLine = CALayer()
        bottomLine.name = "bottomBorder" // so we can remove later if needed
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - height, width: self.frame.width, height: height)
        bottomLine.backgroundColor = color.cgColor
        // Remove old border if any
        self.layer.sublayers?.removeAll(where: { $0.name == "bottomBorder" })
        self.layer.addSublayer(bottomLine)
    }
    
    func applySignUpStyle(
           normalText: String = "Don’t have an account? ",
           signUpText: String = "Sign Up",
           normalColor: UIColor = .label,
           signUpColor: UIColor = .systemBlue
       ) {
           let attributedTitle = NSMutableAttributedString(
               string: normalText,
               attributes: [
                   .foregroundColor: normalColor,
                   .font: UIFont.systemFont(ofSize: 16)
               ]
           )
           
           attributedTitle.append(NSAttributedString(
               string: signUpText,
               attributes: [
                   .foregroundColor: signUpColor,
                   .font: UIFont.boldSystemFont(ofSize: 16)
               ]
           ))
           
           self.setAttributedTitle(attributedTitle, for: .normal)
       }
}

