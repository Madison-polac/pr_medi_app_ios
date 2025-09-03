//
//  CGFloat+Extension.swift
//  AllExtension
//
//  Created by Abhishek Yadav on 25/01/19.
//  Copyright © 2019 Prompt Softech. All rights reserved.
//

import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
