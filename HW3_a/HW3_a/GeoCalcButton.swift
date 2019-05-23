//
//  GeoCalcButton.swift
//  HW3_a
//
//  Created by Reuben B. Nyenhuis on 5/23/19.
//  Copyright © 2019 Jemima Turnbull. All rights reserved.
//

import UIKit

class GeoCalcButton: UIButton {
    
    override func awakeFromNib() {
        
        self.tintColor = BACKGROUND_COLOR
        self.backgroundColor = FOREGROUND_COLOR
        self.layer.cornerRadius = 5.0
    }
}
