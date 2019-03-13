//
//  NextFlightCardView.swift
//  FlightSchedule
//
//  Created by Jason Johnston on 3/12/19.
//  Copyright © 2019 Jason Johnston. All rights reserved.
//

import UIKit

@IBDesignable
class NextFlightCardView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
}
