//
//  LableExtention.swift
//  MediPatient
//
//  Created by Nick Joliya on 21/08/25.
//

import UIKit

class PrimaryLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        applyPrimaryStyle()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyPrimaryStyle()
    }

    private func applyPrimaryStyle() {
        self.font = UIFont.ubuntuRegular(ofSize: 24)
        self.textColor = AppThemeColors.PrimaryTextColor
        self.textAlignment = .left
        self.numberOfLines = 0
        self.adjustsFontSizeToFitWidth = true
    }
}
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
        self.font = UIFont.ubuntuRegular(ofSize: 20)
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
        self.font = UIFont.ubuntuRegular(ofSize: 14)
        self.textColor = AppThemeColors.SecondaryTextColor
        self.textAlignment = .left
        self.numberOfLines = 0
        self.adjustsFontSizeToFitWidth = true
    }
}
