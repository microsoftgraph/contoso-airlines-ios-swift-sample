//
//  CrewListViewCell.swift
//  FlightSchedule
//
//  Copyright (c) Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import UIKit

class CrewListViewCell: UITableViewCell {
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    
    var crewMemberPhoto: UIImage? {
        didSet {
            photoView.image = crewMemberPhoto
        }
    }
    
    var crewMemberName: String? {
        didSet {
            nameLabel.text = crewMemberName
        }
    }
    
    var crewMemberTitle: String? {
        didSet {
            titleLabel.text = crewMemberTitle
        }
    }
    
    var crewMemberMobileNumber: String? {
        didSet {
            guard let mobileNumber = crewMemberMobileNumber else { return }
            if !mobileNumber.isEmpty {
                textButton.isHidden = false
                callButton.isHidden = false
            }
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
    
    @IBAction func callMobile() {
        guard let mobileNumber = crewMemberMobileNumber?.filter("01234567890.".contains) else { return }
        
        UIApplication.shared.open(URL(string: "tel://\(mobileNumber)")!)
    }
    
    @IBAction func textMobile() {
        guard let mobileNumber = crewMemberMobileNumber?.filter("01234567890.".contains) else { return }
        
        UIApplication.shared.open(URL(string: "sms:\(mobileNumber)")!)
    }
}
