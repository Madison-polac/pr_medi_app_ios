//
//  AllergyCell.swift
//  MediPatient
//
//  Created by Nick Joliya on 19/09/25.
//

import UIKit

class AllergyCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var observedOnLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var severityLabel: UILabel!
    @IBOutlet weak var reactionLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    static let identifier = "AllergyCell"
    
    func configure(with allergy: Allergy) {
        nameLabel.text = allergy.name
        observedOnLabel.text = "\(allergy.observedOn)"
        typeLabel.text = "\(allergy.type)"
        
        severityLabel.text = "\(allergy.severity)"
        if allergy.severity.lowercased() == "moderate" {
            severityLabel.textColor = .systemOrange
        } else {
            severityLabel.textColor = .systemBlue
        }
        
        if let reaction = allergy.reaction, !reaction.isEmpty {
            reactionLabel.text = "\(reaction)"
        }
        
        statusLabel.text = allergy.status.rawValue
        statusLabel.textColor = allergy.status.color
    }
}
