//
//  ButtonExtention.swift
//  MediPatient
//
//  Created by Nick Joliya on 21/08/25.
//

import UIKit

extension UIButton {

    func applyPrimaryStyle() {
        self.backgroundColor = AppThemeColors.PrimaryButtonColor // Or your brand color
        self.setTitleColor(AppThemeColors.ButtonTextColor, for: .normal)
        self.titleLabel?.font = UIFont.ubuntuBold(ofSize: 18)
        self.layer.cornerRadius = 14
        self.layer.masksToBounds = true
        self.layer.borderWidth = 0
        self.layer.borderColor = nil
        self.setTitleShadowColor(nil, for: .normal)
    }
    
    func applySecondaryStyle() {
        self.backgroundColor = AppThemeColors.SecondaryButtonColor // Or your brand color
        self.setTitleColor(AppThemeColors.PrimaryTextColor, for: .normal)
        self.titleLabel?.font = UIFont.ubuntuBold(ofSize: 18)
        self.layer.cornerRadius = 14
        self.layer.masksToBounds = true
        self.layer.borderWidth = 0
        self.layer.borderColor = nil
        self.setTitleShadowColor(nil, for: .normal)
    }
}

class PrimaryLinkButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyLinkStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyLinkStyle()
    }
    
    private func applyLinkStyle() {
        // Set Ubuntu font or your theme font
        self.titleLabel?.font = UIFont.ubuntuMedium(ofSize: 16)
        // Remove background and border
        self.backgroundColor = .clear
        self.layer.borderWidth = 0
        self.layer.cornerRadius = 0
    }
    
    // If you want to allow text change after initialization and keep style:
    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.7 : 1
        }
    }
}

