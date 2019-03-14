//
//  GraphEvent.swift
//  FlightSchedule
//
//  Created by Jason Johnston on 3/13/19.
//  Copyright © 2019 Jason Johnston. All rights reserved.
//

import Foundation

struct GraphEvent {
    let id: String?
    let subject: String?
    let location: String?
    let start: Date?
    let end: Date?
    let attendees: [String]?
}

extension GraphEvent {
    init?(json: [String: Any]) {
        guard let id = json["id"] as? String else { return nil }
        
        let subject = json["subject"] as? String
         
        // https://docs.microsoft.com/graph/api/resources/location?view=graph-rest-1.0
        let locationObj = json["location"] as? [String: Any]
        let location = locationObj?["displayName"] as? String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        // https://docs.microsoft.com/graph/api/resources/datetimetimezone?view=graph-rest-1.0
        let startObj = json["start"] as? [String: Any]
        let startISO = startObj?["dateTime"] as? String
        let start = dateFormatter.date(from: startISO!)
        
        let endObj = json["end"] as? [String: Any]
        let endISO = endObj?["dateTime"] as? String
        let end = dateFormatter.date(from: endISO!)
        
        var attendees: [String] = []
        // https://docs.microsoft.com/graph/api/resources/attendee?view=graph-rest-1.0
        let attendeeArray = json["attendees"] as? [[String:Any]]
        attendeeArray?.forEach({
            (attendee: [String:Any]) in
            let emailAddressObj = attendee["emailAddress"] as? [String: Any]
            let emailAddress = emailAddressObj?["address"] as? String
            attendees.append(emailAddress!)
        })
        
        self.id = id
        self.subject = subject
        self.location = location
        self.start = start
        self.end = end
        self.attendees = attendees
    }
}
