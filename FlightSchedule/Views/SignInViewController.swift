//
//  SignInViewController.swift
//  FlightSchedule
//
//  Copyright (c) Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import UIKit
import MSAL

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signIn() {
        print("Sign in")
        AuthenticationManager.instance.signInAccount {
            (account: MSALAccount?, token: String?, error: Error?) in
            guard let userAccount = account, let accessToken = token, error == nil else {
                print("Error signing in: \(error!)")
                return
            }
            
            print("User: \(userAccount.username!)")
            print("Token: \(accessToken)")
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.registerForPushNotifications()
            DispatchQueue.main.async {
                appDelegate.showMainView()
            }
        }
    }
}

