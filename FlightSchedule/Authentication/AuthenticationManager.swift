//
//  AuthenticationManager.swift
//  FlightSchedule
//
//  Copyright (c) Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import Foundation
import MSAL
import MSGraphClientSDK

class AuthenticationManager {
    static let instance = AuthenticationManager()

    private let publicClient: MSALPublicClientApplication?
    private var currentAccount: MSALAccount?

    private init() {
        do {
            // Uncomment this block to enable MSAL logging
            /*
            MSALLogger.shared().piiLoggingEnabled = true
            MSALLogger.shared().level = .verbose
            MSALLogger.shared().setCallback {
                (level: MSALLogLevel, message: String?, containsPII: Bool) in
                guard let logMessage = message else {
                    return
                }

                if !containsPII {
                    print(logMessage)
                }
            }
            */

            let authorityUrl = URL(string: "https://login.microsoftonline.com/\(AppConfig.tenantId)")!
            let authority = try MSALAuthority(url: authorityUrl)
            try publicClient = MSALPublicClientApplication(clientId: AppConfig.appId,
                                                           keychainGroup: "com.microsoft.adalcache",
                                                           authority: authority)

        } catch {
            print("Error creating public client application: \(error)")
            publicClient = nil
        }
    }

    // Get the first account from the MSAL cache
    // App only does a single account sign-in, so first should
    // be the right acccount
    public func getAccount() -> MSALAccount? {
        var acc: MSALAccount?
        do {
            acc = try publicClient?.allAccounts().first
        } catch {
            print("Error getting account: \(error)")
        }

        guard let account = acc else { return nil }
        return account
    }

    // Sign in interactively
    public func signInAccount(completion: @escaping(MSALAccount?, _ accessToken: String?, Error?) -> Void) {
        publicClient?.acquireToken(forScopes: AppConfig.scopes, completionBlock: {
            (result: MSALResult?, error: Error?) in
            guard let tokenResult = result, error == nil else {
                completion(nil, nil, error)
                return
            }

            self.authenticateNotificationService(completion: {
                (error: Error?) in
                if error != nil {
                    print("Error connecting user to Graph notification service: \(String(describing: error))")
                }
                
                completion(tokenResult.account, tokenResult.accessToken, nil)
            })
        })
    }

    // Sign out
    public func signOutAccounts() {
        do {
            let accounts = try publicClient?.allAccounts()

            try accounts!.forEach {
                account in
                try publicClient?.remove(account)
            }
        } catch {
            print("Sign out error: \(error)")
        }

    }

    // Get a token for Graph scopes
    public func getGraphToken(completion: @escaping(_ accessToken: String?, Error?) -> Void) {
        // First attempt to get token silently
        var firstAccount: MSALAccount?
        do {
            firstAccount = try publicClient?.allAccounts().first
        } catch {
            print("Error getting account: \(error)")
        }

        if (firstAccount != nil) {
            // Try getting token silently
            publicClient?.acquireTokenSilent(forScopes: AppConfig.scopes, account: firstAccount!, completionBlock: {
                (result: MSALResult?, error: Error?) in
                guard let authResult = result, error == nil else {
                    print("Error getting token silently: \(error!)")
                    completion(nil, error)
                    return
                }

                print("Access token obtained silently: \(authResult.accessToken)")
                completion(authResult.accessToken, nil)
            })
        } else {
            print("No accounts in cache")
            completion(nil, NSError(domain: "AuthenticationManager", code: MSALErrorCode.accountRequired.rawValue, userInfo: nil))
        }
    }
    
    public func authenticateNotificationService(completion: @escaping(Error?) -> Void) {
        // First attempt to get token silently
        var firstAccount: MSALAccount?
        do {
            firstAccount = try publicClient?.allAccounts().first
        } catch {
            print("Error getting account: \(error)")
        }
        
        if (firstAccount != nil) {
            // Try getting token silently
            publicClient?.acquireTokenSilent(forScopes: AppConfig.notificationScopes, account: firstAccount!, completionBlock: {
                (result: MSALResult?, error: Error?) in
                guard let authResult = result, error == nil else {
                    print("Error getting token silently: \(error!)")
                    completion(error)
                    return
                }
                
                print("Access token for notifications obtained silently: \(authResult.accessToken)")
                
                let url = URL(string: "\(AppConfig.notificationApiEndpoint)/api/ConnectGraphNotifications")!
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("Bearer \(authResult.accessToken)", forHTTPHeaderField: "Authorization")
                
                let task = URLSession.shared.dataTask(with: request)
                task.resume()
                completion(nil)
            })
        } else {
            print("No accounts in cache")
            completion(NSError(domain: "AuthenticationManager", code: MSALErrorCode.accountRequired.rawValue, userInfo: nil))
        }
    }
    
    public func getPublicClientApp() -> MSALPublicClientApplication? {
        return publicClient
    }
}
