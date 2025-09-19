//
//  Token.swift
//  MediPatient
//
//  Created by Nick Joliya on 19/09/25.
//

import UIKit


struct Token {
    let date: String
    let time: String
    let facility: String
    let provider: String
    let tokenNumber: Int
    let status: Status
}

enum Status: String {
    case cancelled = "Cancelled"
    case completed = "Completed"
    case waiting = "Waiting"
    case ongoing = "On Going"
    
    var color: UIColor {
        switch self {
        case .cancelled: return .systemRed
        case .completed: return .systemGreen
        case .waiting: return .systemOrange
        case .ongoing: return .systemBlue
        }
    }
}
