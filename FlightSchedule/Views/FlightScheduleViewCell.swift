//
//  FlightScheduleViewCell.swift
//  FlightSchedule
//
//  Copyright (c) Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import UIKit

class FlightScheduleViewCell: UITableViewCell {

    @IBOutlet weak var flightNameLabel: UILabel!
    @IBOutlet weak var departureTimeLabel: UILabel!
    
    var flightName: String? {
        didSet {
            flightNameLabel.text = flightName
        }
    }
    
    var departureTime: String? {
        didSet {
            departureTimeLabel.text = departureTime
        }
    }
    
    var indexForCell: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
