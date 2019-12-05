//
//  CustomButton.swift
//  TicTacToe
//
//  Created by Vidya on 04/12/19.
//  Copyright © 2019 VidyaPrasad. All rights reserved.
//

import UIKit

@IBDesignable extension UIButton {
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}
