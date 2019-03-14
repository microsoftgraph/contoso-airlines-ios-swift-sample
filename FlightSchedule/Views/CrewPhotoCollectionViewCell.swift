//
//  CrewPhotoCollectionViewCell.swift
//  FlightSchedule
//
//  Copyright (c) Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import UIKit

class CrewPhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet var crewImageView: UIImageView!
    
    // Make the images circular with a border
    override func layoutSubviews() {
        crewImageView.layer.borderWidth = 1
        crewImageView.layer.masksToBounds = false
        crewImageView.layer.borderColor = UIColor.black.cgColor
        crewImageView.layer.cornerRadius = crewImageView.frame.height/2
        crewImageView.clipsToBounds = true
    }
}
