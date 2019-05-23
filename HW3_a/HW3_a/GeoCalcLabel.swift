//
//  GeoCalcLabel.swift
//  HW3_a
//
//  Created by Reuben B. Nyenhuis on 5/23/19.
//  Copyright © 2019 Jemima Turnbull. All rights reserved.
//

import UIKit

class GeoCalcLabel: UILabel {
    override func awakeFromNib() {
        
        self.tintColor = FOREGROUND_COLOR
        self.textColor = FOREGROUND_COLOR
        self.layer.cornerRadius = 5.0
    }
}
