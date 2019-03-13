//
//  GraphUser.swift
//  FlightSchedule
//
//  Created by Jason Johnston on 3/8/19.
//  Copyright © 2019 Jason Johnston. All rights reserved.
//

import Foundation

struct GraphUser {
    let displayName: String?
    let businessPhones: [String]?
    let id: String?
    let mail: String?
    let mobilePhone: String?
}

extension GraphUser {
    init?(json: [String: Any]) {
        guard let id = json["id"] as? String else { return nil }
        
        let displayName = json["displayName"] as? String
        let businessPhones = json["businessPhones"] as? [String]
        
        let mail = json["mail"] as? String
        let mobilePhone = json["mobilePhone"] as? String
        
        self.displayName = displayName
        self.businessPhones = businessPhones
        self.id = id
        self.mail = mail
        self.mobilePhone = mobilePhone
    }
}
