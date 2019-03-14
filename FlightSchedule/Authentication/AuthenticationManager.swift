//
//  AuthenticationManager.swift
//  FlightSchedule
//
//  Created by Jason Johnston on 3/6/19.
//  Copyright © 2019 Jason Johnston. All rights reserved.
//

import Foundation
import MSAL
import MSGraphClientSDK

class AuthenticationManager {
    static let instance = AuthenticationManager()

    private let publicClient: MSALPublicClientApplication?
    private var currentAccount: MSALAccount?

    //private let authContext: ADAuthenticationContext?

    private init() {
        do {
            MSALLogger.shared().setCallback {
                (level: MSALLogLevel, message: String?, containsPII: Bool) in
                guard let logMessage = message else {
                    return
                }

                if !containsPII {
                    print(logMessage)
                }
            }

            let authorityUrl = URL(string: "https://login.microsoftonline.com/\(AppConfig.tenantId)")!
            let authority = try MSALAuthority(url: authorityUrl)
            try publicClient = MSALPublicClientApplication(clientId: AppConfig.appId,
                                                           keychainGroup: Bundle.main.bundleIdentifier!,
                                                           authority: authority)

        } catch {
            print("Error creating public client application: \(error)")
            publicClient = nil
        }
    }

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

    public func signInAccount(completion: @escaping(MSALAccount?, _ accessToken: String?, Error?) -> Void) {
        publicClient?.acquireToken(forScopes: AppConfig.scopes, completionBlock: {
            (result: MSALResult?, error: Error?) in
            guard let tokenResult = result, error == nil else {
                completion(nil, nil, error)
                return
            }

            completion(tokenResult.account, tokenResult.accessToken, nil)
        })
    }

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

    public func getTokenWithScopes(scopes: [String], completion: @escaping(_ accessToken: String?, Error?) -> Void) {
        let account = getAccount()

        guard let userAccount = account else {
            let error = NSError(domain: "AuthenticationManager", code: MSALErrorCode.accountRequired.rawValue, userInfo: nil)
            completion(nil, error);
            return;
        }

        publicClient?.acquireTokenSilent(
            forScopes: scopes,
            account: userAccount, completionBlock: {
                (result: MSALResult?, error: Error?) in

                guard let tokenResult = result, error == nil else {
                    completion(nil, error)
                    return
                }

                completion(tokenResult.accessToken, nil)
        })
    }
}
