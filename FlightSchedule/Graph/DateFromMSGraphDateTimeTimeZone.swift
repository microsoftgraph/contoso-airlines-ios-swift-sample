//
//  DateFromMSGraphDateTimeTimeZone.swift
//  FlightSchedule
//
//  Copyright (c) Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
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
