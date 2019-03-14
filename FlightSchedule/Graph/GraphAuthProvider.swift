//
//  GraphAuthProvider.swift
//  FlightSchedule
//
//  Copyright (c) Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import Foundation
import MSGraphClientSDK

class GraphAuthProvider: NSObject, MSAuthenticationProvider {
    func getAccessToken(completion: ((String?, Error?) -> Void)!) {
        AuthenticationManager.instance.getGraphToken(completion: completion)
    }
}
