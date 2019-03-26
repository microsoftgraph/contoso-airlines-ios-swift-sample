//
//  TokenGetter.swift
//  ProjectRomeTokens
//
//  Copyright (c) Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import ADAL

public class TokenGetter {
    
    private var applicationId: String?
    private var authorityUrl: String?
    
    public init(appId: String, tenantId: String) {
        applicationId = appId
        authorityUrl = "https://login.microsoftonline.com/\(tenantId)"
    }
    
    public func getProjectRomeToken(resource: String, userId: String, completion: @escaping(_ accessToken: String?, Error?) -> Void) {
        
        let authContext = ADAuthenticationContext(authority: authorityUrl, error: nil)
        
        authContext?.acquireTokenSilent(withResource: resource, clientId: applicationId, redirectUri: URL(string: "urn:ietf:wg:oauth:2.0:oob"), userId: userId, completionBlock: {
            (result: ADAuthenticationResult?) in
            guard let authResult = result else {
                print("ADAL returned no result??")
                completion(nil, NSError(domain: "ProjectRomeTokens", code: ADErrorCode.ERROR_UNEXPECTED.rawValue, userInfo: nil))
                return
            }
            
            if authResult.status != AD_SUCCEEDED {
                completion(nil, authResult.error)
                return
            }
            
            completion(authResult.accessToken, nil)
        })
    }
}
