//
//  DateFromMSGraphDateTimeTimeZone.swift
//  FlightSchedule
//
//  Created by Jason Johnston on 3/28/19.
//  Copyright © 2019 Jason Johnston. All rights reserved.
//

import Foundation
import MSGraphClientModels

extension Date {
    init(from: MSGraphDateTimeTimeZone) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"
        dateFormatter.timeZone = TimeZone(identifier: from.timeZone!)
        
        let date = dateFormatter.date(from: from.dateTime)
        
        self.init(timeInterval: 0, since: date!)
    }
}
