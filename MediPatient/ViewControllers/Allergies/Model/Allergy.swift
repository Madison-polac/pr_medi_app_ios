//
//  Allergy.swift
//  MediPatient
//
//  Created by Nick Joliya on 19/09/25.
//


import UIKit

enum AllergyStatus: String {
    case active = "Active"
    case inactive = "In Active"
    
    var color: UIColor {
        switch self {
        case .active: return .systemGreen
        case .inactive: return .systemRed
        }
    }
}

struct Allergy {
    let name: String
    let observedOn: String
    let type: String
    let severity: String
    let reaction: String?
    let status: AllergyStatus
}
