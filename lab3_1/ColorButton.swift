//
//  colorButton.swift
//  lab3_1
//
//  Created by Nikash Taskar on 10/1/19.
//  Copyright © 2019 Nikash Taskar. All rights reserved.
//

import Foundation
import UIKit

class ColorButton: UIButton {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 0.5 * 32
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.darkGray.cgColor
    }
}
