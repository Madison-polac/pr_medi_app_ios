//
//  SideMenuHeaderCell.swift
//  MediPatient
//
//  Created by Nick Joliya on 16/09/25.
//

import UIKit

class SideMenuHeaderCell: UITableViewCell {
    static let identifier = "SideMenuHeaderCell"
    
    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPatientID: UILabel!
    
    func configure(name: String, email: String, profileImage: String) {
        lblName.text = name
        lblEmail.text = email
        ivProfile.image = UIImage(named: profileImage)
        ivProfile.layer.cornerRadius = ivProfile.frame.height / 2
        ivProfile.clipsToBounds = true
    }
}
