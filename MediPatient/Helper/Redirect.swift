//
//  Redirect.swift
//  MediPatient
//
//  Created by Nick Joliya on 01/09/25.
//


import UIKit

class Redirect {
    // Push navigation
    static func to(_ identifier: String, from vc: UIViewController, animated: Bool = true) {
        guard let targetVC = vc.storyboard?.instantiateViewController(identifier: identifier) else { return }
        vc.navigationController?.pushViewController(targetVC, animated: animated)
    }
    
    // Present modally
    static func present(_ identifier: String, from vc: UIViewController, animated: Bool = true) {
        guard let targetVC = vc.storyboard?.instantiateViewController(identifier: identifier) else { return }
        vc.present(targetVC, animated: animated)
    }
    
    // Pop to previous
    static func pop(from vc: UIViewController, animated: Bool = true) {
        vc.navigationController?.popViewController(animated: animated)
    }
    
    // Pop to root
    static func popToRoot(from vc: UIViewController, animated: Bool = true) {
        vc.navigationController?.popToRootViewController(animated: animated)
    }
}

