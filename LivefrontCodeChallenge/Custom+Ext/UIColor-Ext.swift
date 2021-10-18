//
//  UIColor_Ext.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/8/21.
//

import Foundation
import UIKit

extension UIColor {
    /// Provide with a desired color for dark and light modes
    static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return light }
        return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
    }
}
