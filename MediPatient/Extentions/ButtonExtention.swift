//
//  ButtonExtention.swift
//  MediPatient
//
//  Created by Nick Joliya on 21/08/25.
//

import UIKit

extension UIButton {

    func applyPrimaryStyle() {
        self.backgroundColor = UIColor.systemTeal // Or your brand color
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderWidth = 0
        self.layer.borderColor = nil
        self.setTitleShadowColor(nil, for: .normal)
    }
}
