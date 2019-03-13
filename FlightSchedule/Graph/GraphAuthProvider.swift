//
//  GraphAuthProvider.swift
//  FlightSchedule
//
//  Created by Jason Johnston on 3/8/19.
//  Copyright © 2019 Jason Johnston. All rights reserved.
//

import Foundation
import MSGraphClientSDK

class GraphAuthProvider: NSObject, MSAuthenticationProvider {
    func getAccessToken(completion: ((String?, Error?) -> Void)!) {
        AuthenticationManager.instance.getGraphToken(completion: completion)
    }
}
