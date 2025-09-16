//
//  SideMenuCell.swift
//  MediPatient
//
//  Created by Nick Joliya on 16/09/25.
//

import UIKit

class SideMenuCell: UITableViewCell {
    static let identifier = "SideMenuCell"
    
    @IBOutlet weak var ivIcon: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    func configure(iconName: String, title: String) {
        ivIcon.setImage(UIImage(systemName: iconName), for: .normal) 
        lblTitle.text = title
    }
}
