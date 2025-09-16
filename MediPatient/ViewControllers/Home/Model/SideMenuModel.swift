//
//  SideMenuModel.swift
//  MediPatient
//
//  Created by Nick Joliya on 16/09/25.
//

import Foundation

struct SideMenuHeaderModel {
    let name: String
    let email: String
    let profileImage: String
}

struct SideMenuItemModel {
    let iconName: String
    let title: String
}

struct SideMenuData {
    let header: SideMenuHeaderModel
    let items: [SideMenuItemModel]
    
    static func getMenuData() -> SideMenuData {
        return SideMenuData(
            header: SideMenuHeaderModel(
                name: "Lawrence Rao",
                email: "lawrence@mail.com",
                profileImage: "profile"
            ),
            items: [
                SideMenuItemModel(iconName: "doc.text", title: "Clinical Summary"),
                SideMenuItemModel(iconName: "clock", title: "Timeline"),
                SideMenuItemModel(iconName: "shield", title: "Insurance"),
                SideMenuItemModel(iconName: "cross.case", title: "Pharmacies"),
                SideMenuItemModel(iconName: "heart.text.square", title: "Problems / History"),
                SideMenuItemModel(iconName: "pills", title: "Medications"),
                SideMenuItemModel(iconName: "cross", title: "Urgent Care"),
                SideMenuItemModel(iconName: "calendar", title: "Appointments"),
                SideMenuItemModel(iconName: "message", title: "Messages"),
                SideMenuItemModel(iconName: "doc.plaintext", title: "Patient Forms"),
                SideMenuItemModel(iconName: "list.bullet.rectangle", title: "Visit Summary"),
                SideMenuItemModel(iconName: "doc.text", title: "Clinical Summary"),
                SideMenuItemModel(iconName: "clock", title: "Timeline"),
                SideMenuItemModel(iconName: "shield", title: "Insurance"),
                SideMenuItemModel(iconName: "cross.case", title: "Pharmacies"),
                SideMenuItemModel(iconName: "heart.text.square", title: "Problems / History"),
                SideMenuItemModel(iconName: "pills", title: "Medications"),
                SideMenuItemModel(iconName: "cross", title: "Urgent Care"),
                SideMenuItemModel(iconName: "calendar", title: "Appointments"),
                SideMenuItemModel(iconName: "message", title: "Messages"),
                SideMenuItemModel(iconName: "doc.plaintext", title: "Patient Forms"),
                SideMenuItemModel(iconName: "list.bullet.rectangle", title: "Visit Summary")
            ]
        )
    }
}
