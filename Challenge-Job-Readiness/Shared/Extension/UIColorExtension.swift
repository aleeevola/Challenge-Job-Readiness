//
//  UIColorExtension.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 13/09/2022.
//

import Foundation
import UIKit

#warning("CamelCase instead of SnakeCase")
#warning("Keep consistensy in every initialization, 153/255 or 0.99 or Hex, you can leave a comment for example HexFFFFFF, RGBA(R: 255/255, G: 255/255, B: 255/255, A: 1.0) or RGBA(R: 1.0, G:1.0, B:1.0, a: 1.0)")
extension UIColor {
    static var andes_brand : UIColor { return UIColor(red: 0.99, green: 0.87, blue: 0.07, alpha: 1.00)}
    static var andes_gray_100 : UIColor { return UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)}
    static var andes_text_color_primary : UIColor { return UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)}
    static var grey4 : UIColor { return UIColor(red: 153/255, green: 155/255, blue: 156/255, alpha: 1)}
}
