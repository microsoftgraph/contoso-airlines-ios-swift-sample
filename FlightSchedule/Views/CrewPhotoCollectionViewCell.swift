//
//  CrewPhotoCollectionViewCell.swift
//  FlightSchedule
//
//  Created by Jason Johnston on 3/12/19.
//  Copyright © 2019 Jason Johnston. All rights reserved.
//

import UIKit

class CrewPhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet var crewImageView: UIImageView!
    
    override func layoutSubviews() {
        crewImageView.layer.borderWidth = 1
        crewImageView.layer.masksToBounds = false
        crewImageView.layer.borderColor = UIColor.black.cgColor
        crewImageView.layer.cornerRadius = crewImageView.frame.height/2
        crewImageView.clipsToBounds = true
    }
}
