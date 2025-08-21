//
//  LableExtention.swift
//  MediPatient
//
//  Created by Nick Joliya on 21/08/25.
//

import UIKit

class HeadingLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        applyPrimaryStyle()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyPrimaryStyle()
    }

    private func applyPrimaryStyle() {
        self.font = UIFont.boldSystemFont(ofSize: 28)
        self.textColor = AppThemeColors.PrimaryTextColor
        self.textAlignment = .left
        self.numberOfLines = 0
        self.adjustsFontSizeToFitWidth = true
    }
}
class DescriptionLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        applyPrimaryStyle()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyPrimaryStyle()
    }

    private func applyPrimaryStyle() {
        self.font = UIFont.boldSystemFont(ofSize: 14)
        self.textColor = AppThemeColors.SecondaryTextColor
        self.textAlignment = .left
        self.numberOfLines = 0
        self.adjustsFontSizeToFitWidth = true
    }
}
