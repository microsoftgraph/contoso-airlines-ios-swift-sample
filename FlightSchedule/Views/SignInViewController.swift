//
//  SignInViewController.swift
//  FlightSchedule
//
//  Created by Jason Johnston on 3/5/19.
//  Copyright © 2019 Jason Johnston. All rights reserved.
//

import UIKit
import MSAL

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
            appDelegate.showMainView()
        }
    }
}

