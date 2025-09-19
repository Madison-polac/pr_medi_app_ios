//
//  TokenCell.swift
//  MediPatient
//
//  Created by Nick Joliya on 19/09/25.
//

import UIKit

class TokenCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var facilityLabel: UILabel!
    @IBOutlet weak var providerLabel: UILabel!
    @IBOutlet weak var tokenLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    static let identifier = "TokenCell"
    
    func configure(with token: Token) {
        dateLabel.text = "\(token.date)   \(token.time)"
        facilityLabel.text = "\(token.facility)"
        providerLabel.text = "\(token.provider)"
        tokenLabel.text = " \(token.tokenNumber)"
        statusLabel.text = "\(token.status.rawValue)"
        statusLabel.textColor = token.status.color
    }
}
