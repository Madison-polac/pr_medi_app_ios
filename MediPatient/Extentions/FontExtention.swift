//
//  FontExtention.swift
//  MediPatient
//
//  Created by Nick Joliya on 21/08/25.
//

import UIKit

extension UIFont {

    static func ubuntuRegular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Ubuntu-Regular", size: size) ??
               UIFont.systemFont(ofSize: size)
    }

    static func ubuntuBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Ubuntu-Bold", size: size) ??
               UIFont.boldSystemFont(ofSize: size)
    }
    static func ubuntuMedium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Ubuntu-Medium", size: size) ??
               UIFont.systemFont(ofSize: size)
    }

    static func ubuntuLight(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Ubuntu-Light", size: size) ??
               UIFont.boldSystemFont(ofSize: size)
    }
   
}

