//
//  FlightDataEventExtension.swift
//  FlightSchedule
//
//  Copyright (c) Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import Foundation

// Struct to map to the open extension saved on these events
// The open extension holds custom data about the flight
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
