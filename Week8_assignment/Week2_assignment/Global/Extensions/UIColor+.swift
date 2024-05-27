//
//  UIColor+.swift
//  Week3_assignment
//
//  Created by 오서영 on 2024/05/03.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static var gray9C: UIColor {
        return UIColor(red: 156/255.0, green: 156/255.0, blue: 156/255.0, alpha: 1.0)
    }
    
    static var customBlue: UIColor {
        return UIColor(red: 70/255.0, green: 130/255.0, blue: 180/255.0, alpha: 1.0)
    }
}

