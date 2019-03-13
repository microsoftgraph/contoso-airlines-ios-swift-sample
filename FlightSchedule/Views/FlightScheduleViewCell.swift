//
//  FlightScheduleViewCell.swift
//  FlightSchedule
//
//  Created by Jason Johnston on 3/12/19.
//  Copyright © 2019 Jason Johnston. All rights reserved.
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
