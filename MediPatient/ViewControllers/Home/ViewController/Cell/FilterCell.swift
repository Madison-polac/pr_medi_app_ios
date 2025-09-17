//
//  FilterCell.swift
//  MediPatient
//
//  Created by Nick Joliya on 17/09/25.
//

import UIKit

class FilterCell: UITableViewCell {
    static let identifier = "FilterCell"
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    var onToggle: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
     

    }
    
    func configure(with item: FilterItem, isFirstRow: Bool = false) {
        lblTitle.text = item.title
        
        if isFirstRow {
            // Use custom images for first row
            let imageName = item.isSelected ? "icRadio" : "ic_Unchecked"
            checkButton.setImage(UIImage(named: imageName), for: .normal)
            lblTitle.textColor =  .systemBlue // or any color you want
            lblTitle.font = UIFont.ubuntuMedium(ofSize: 17)
        } else {
            // Use SF Symbols for normal rows
            let iconName = item.isSelected ? "ic_Checked" : "ic_Unchecked"
            checkButton.setImage(UIImage(named: iconName), for: .normal)
            lblTitle.textColor = ._101010
            lblTitle.font = UIFont.ubuntuRegular(ofSize: 17)
        }
    }
    
    
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        onToggle?()
    }
}
