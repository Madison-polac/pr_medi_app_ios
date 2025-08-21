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
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.layer.cornerRadius = 14
        self.layer.masksToBounds = true
        self.layer.borderWidth = 0
        self.layer.borderColor = nil
        self.setTitleShadowColor(nil, for: .normal)
    }
}
