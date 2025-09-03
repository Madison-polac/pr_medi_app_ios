//
//  HUD.swift
//  MediPatient
//
//  Lightweight wrapper around MBProgressHUD
//

import UIKit
import MBProgressHUD

final class HUD {
    private init() {}

    @discardableResult
    static func show(on view: UIView?, text: String? = nil, animated: Bool = true) -> MBProgressHUD? {
        guard let targetView = view ?? UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return nil }
        let hud = MBProgressHUD.showAdded(to: targetView, animated: animated)
        hud.mode = .indeterminate
        hud.label.text = text
        hud.removeFromSuperViewOnHide = true
        return hud
    }

    static func hide(from view: UIView?, animated: Bool = true) {
        if let targetView = view ?? UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            MBProgressHUD.hide(for: targetView, animated: animated)
        }
    }
}


