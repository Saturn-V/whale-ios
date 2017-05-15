//
//  UIImageViewExt.swift
//  whale-ios-AlexPena
//
//  Created by Alex Aaron Peña on 4/12/17.
//  Copyright © 2017 Alex Aaron Peña. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
extension UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
