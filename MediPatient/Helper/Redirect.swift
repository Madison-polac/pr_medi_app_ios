//
//  Redirect.swift
//  MediPatient
//
//  Created by Nick Joliya on 01/09/25.
//


import UIKit

class Redirect {
    // Push with configuration
    static func to<T: UIViewController>(
        _ identifier: String,
        from vc: UIViewController,
        animated: Bool = true,
        configure: ((T) -> Void)? = nil
    ) {
        guard let targetVC = vc.storyboard?.instantiateViewController(identifier: identifier) as? T else { return }
        configure?(targetVC)   // ✅ pass values here
        vc.navigationController?.pushViewController(targetVC, animated: animated)
    }

    // Present with configuration
    static func present<T: UIViewController>(
        _ identifier: String,
        from vc: UIViewController,
        animated: Bool = true,
        configure: ((T) -> Void)? = nil
    ) {
        guard let targetVC = vc.storyboard?.instantiateViewController(identifier: identifier) as? T else { return }
        configure?(targetVC)   // ✅ pass values here
        vc.present(targetVC, animated: animated)
    }

    // Pop
    static func pop(from vc: UIViewController, animated: Bool = true) {
        vc.navigationController?.popViewController(animated: animated)
    }

    static func popToRoot(from vc: UIViewController, animated: Bool = true) {
        vc.navigationController?.popToRootViewController(animated: animated)
    }
}


