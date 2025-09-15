//
//  CardItem.swift
//  MediPatient
//
//  Created by Nick Joliya on 15/09/25.
//

import Foundation
enum CardType {
    case common, videoAppointment
}

struct CardItem {
    let type: CardType
    let iconName: String?       // SF Symbol or asset name
    let title: String
    let subtitle: String?
    let description: String?
    let statusText: String?
    let showJoinButton: Bool
}
