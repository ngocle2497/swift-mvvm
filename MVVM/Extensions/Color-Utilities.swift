//
//  Color-Utilities.swift
//  MVVM
//
//  Created by Ngoc H. Le on 07/03/2024.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(_ red: CGFloat,_ green: CGFloat,_ blue: CGFloat,_ alpha: CGFloat) {
         self.init(red: red / 255.5, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
}
