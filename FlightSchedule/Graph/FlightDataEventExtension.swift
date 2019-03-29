//
//  FlightDataEventExtension.swift
//  FlightSchedule
//
//  Created by Jason Johnston on 3/29/19.
//  Copyright © 2019 Jason Johnston. All rights reserved.
//

import Foundation

struct FlightDataEventExtension {
    let departureGate: String?
    let crewMembers: [String]?
}

extension FlightDataEventExtension {
    init?(extensions: [Any]?) {
        
        guard let extensionsArray = extensions else {
            self.departureGate = ""
            self.crewMembers = nil
            return
        }
        
        guard let extensionJson = extensionsArray[0] as? [String: Any] else {
            self.departureGate = ""
            self.crewMembers = nil
            return
        }
        
        let departureGate = extensionJson["departureGate"] as? String
        let crewMembers = extensionJson["crewMembers"] as? [String]
        
        self.departureGate = departureGate
        self.crewMembers = crewMembers
    }
}
