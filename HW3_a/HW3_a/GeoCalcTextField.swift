//
//  GeoCalcTextField.swift
//  HW3_a
//
//  Created by Reuben B. Nyenhuis on 5/23/19.
//  Copyright © 2019 Jemima Turnbull. All rights reserved.
//

import UIKit

class GeoCalcTextField: DecimalMinusTextField {
    
    override func awakeFromNib() {
        
        self.tintColor = FOREGROUND_COLOR
        self.backgroundColor = UIColor.clear
        self.borderStyle = .roundedRect
        self.layer.borderWidth = 1.0
        self.layer.borderColor = FOREGROUND_COLOR.cgColor
        self.layer.cornerRadius = 5.0
        self.textColor = FOREGROUND_COLOR
        
        
        
        guard let ph = self.placeholder else {
            return
        }
        
        self.attributedPlaceholder =
            NSAttributedString(string: ph, attributes: [NSAttributedString.Key.foregroundColor : FOREGROUND_COLOR])
        
        
    }

}
