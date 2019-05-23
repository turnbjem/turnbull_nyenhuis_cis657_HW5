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
        self.backgroundColor = BACKGROUND_COLOR
        self.layer.borderWidth = 1.0
        self.textColor = FOREGROUND_COLOR
        self.borderStyle = .roundedRect
        
        guard let ph = self.placeholder else {
            return
        }
        
        self.attributedPlaceholder =
            NSAttributedString(string: ph, attributes: [NSAttributedString.Key.foregroundColor : FOREGROUND_COLOR])
        
        
    }

}
