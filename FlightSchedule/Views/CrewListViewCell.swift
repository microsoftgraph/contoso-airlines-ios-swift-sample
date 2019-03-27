//
//  CrewListViewCell.swift
//  FlightSchedule
//
//  Created by Jason Johnston on 3/27/19.
//  Copyright © 2019 Jason Johnston. All rights reserved.
//

import UIKit

class CrewListViewCell: UITableViewCell {
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    
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
            mobileNumberLabel.text = crewMemberMobileNumber
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
