//
//  Double+Extensions.swift
//  SplashTrack
//
//  Created by Mehul Patel on 18/02/19.
//  Copyright © 2019 Prompt. All rights reserved.
//

import Foundation
import UIKit

public extension Double {
    /// Rounds the double to decimal places value
    func roundValue(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
