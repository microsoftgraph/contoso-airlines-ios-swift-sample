//
//  NotificationManager.swift
//  FlightSchedule
//
//  Copyright (c) Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import Foundation
import ConnectedDevices
import MSAL
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager()

    private let platform: MCDConnectedDevicesPlatform
    private let registration: MCDConnectedDevicesNotificationRegistration
    private var channel: MCDUserNotificationChannel?
    private var reader: MCDUserNotificationReader?
    private var readerSubscription: MCDEventSubscription?
    private var currentNotifications: [MCDUserNotification]

    private init() {
        platform = MCDConnectedDevicesPlatform()!

        currentNotifications = []

        registration = MCDConnectedDevicesNotificationRegistration()
        registration.type = MCDConnectedDevicesNotificationType.notificationTypeAPN
        registration.appId = Bundle.main.bundleIdentifier!
        registration.appDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String

        // Called by Project Rome SDK when it needs an access token
        platform.accountManager.accessTokenRequested.subscribe {
            (acctMgr, eventArgs) in

            print("Original scopes: \(eventArgs.request.scopes)")

            var askScopes: [String] = []

            if eventArgs.request.scopes.contains("https://wns.windows.com/") {
                askScopes.append("https://wns.windows.com/.default")
            } else if eventArgs.request.scopes.contains("https://cdpcs.access.microsoft.com") {
                askScopes.append("https://cdpcs.access.microsoft.com/.default")
            } else if eventArgs.request.scopes.contains("https://activity.microsoft.com") {
                askScopes.append("https://activity.microsoft.com/.default")
            } else if eventArgs.request.scopes.contains("https://cs.dds.microsoft.com") {
                askScopes.append("https://cs.dds.microsoft.com/.default")
            }

            print("Requesting scopes: \(askScopes)")
            // Get token from MSAL
            AuthenticationManager.instance.getTokenWithScopes(scopes: askScopes, completion: {
                (token: String?, error: Error?) in
                guard let accessToken = token, error == nil else {
                    eventArgs.request.completeWithErrorMessage("Could not get token: \(error!)")
                    return
                }
                print("MCD token: \(accessToken)")
                eventArgs.request.complete(withAccessToken: accessToken)
            })
        }

        platform.accountManager.accessTokenInvalidated.subscribe {
            (acctMgr, eventArgs) in
            print("Access token with scopes: [\(eventArgs.scopes)] invalidated for account id \(eventArgs.account.accountId)")
        }

        platform.notificationRegistrationManager.notificationRegistrationStateChanged.subscribe {
            (registrationManager, eventArgs) in
            print("Notification registration state changed to \(eventArgs.state)")
            if (eventArgs.state == MCDConnectedDevicesNotificationRegistrationState.expired ||
                eventArgs.state == MCDConnectedDevicesNotificationRegistrationState.expiring) {
                // Refresh registration
                print("Notification expired, refreshing")
                self.refresh()
            }
        }
    }

    public func start() {
        platform.start()
    }

    // Takes the APNS device token and register that with
    // the Project Rome cross-device notification service
    public func registerWithDeviceToken(deviceToken: String) {
        self.registration.token = deviceToken

        let userAccount = AuthenticationManager.instance.getAccount()
        let mcdAccount = MCDConnectedDevicesAccount(accountId: (userAccount?.homeAccountId?.identifier)!, type: MCDConnectedDevicesAccountType.AAD)

        // Add the account to the CD platform
        platform.accountManager.addAccountAsync(mcdAccount!) {
            (_: MCDConnectedDevicesAddAccountResult?, error: Error?) in

            guard error == nil else {
                print("Error adding account to account manager: \(error!)")
                return;
            }

            // Register for CD notifications
            self.platform.notificationRegistrationManager.register(forAccountAsync: mcdAccount!, registration: self.registration, callback: {
                (result: Bool, error: Error?) in
                guard error == nil else {
                    print("Failed to register for notifications: \(error!)")
                    return
                }

                let dataFeed = MCDUserDataFeed.getFor(mcdAccount!, platform: self.platform, activitySourceHost: AppConfig.notificationDomain)

                // Subscribe to the incoming notification feed
                dataFeed?.subscribe(toSyncScopesAsync: [MCDUserNotificationChannel.syncScope], callback: {
                    (result: Bool, error: Error?) in
                    guard error == nil else {
                        print("Failed to subscribe for sync scopes: \(error!)")
                        return
                    }

                    self.channel = MCDUserNotificationChannel.init(userDataFeed: dataFeed!)
                    self.reader = self.channel?.createReader()
                    self.readerSubscription = self.reader?.dataChanged.subscribe({
                        (_: MCDUserNotificationReader, _: MCDUserNotificationReaderDataChangedEventArgs) in
                        print("Data changed")
                        self.doRead()
                    })
                })
            })
        }
    }

    // Attempts to process an incoming APNS notification as
    // a Project Rome notification
    public func processNotification(userInfo: [AnyHashable: Any]) {
        let operation = platform.processNotification(userInfo)
        if !operation.isConnectedDevicesNotification {
            print ("Notification not from Graph")
        }
    }

    // Read the incoming notification feed
    private func doRead() {
        self.reader?.readBatchAsync(withMaxSize: UInt.max, completion: {
            (notifications: [MCDUserNotification]?, error: Error?) in
            guard error == nil else {
                print("Error reading notifications: \(error!)")
                return
            }

            guard let userNotifications = notifications else { return }

            print("Received \(userNotifications.count) notifications")

            userNotifications.forEach({
                (notification: MCDUserNotification) in
                // Check current notifications for a match
                for i in 0..<self.currentNotifications.count {
                    if self.currentNotifications[i].notificationId == notification.notificationId {
                        self.currentNotifications.remove(at: i)
                        break
                    }
                }

                if notification.status == MCDUserNotificationStatus.active {
                    print("Notification \(notification.notificationId) is active")
                    self.currentNotifications.insert(notification, at: 0)

                    if (notification.userActionState == MCDUserNotificationUserActionState.noInteraction) &&
                        (notification.readState == MCDUserNotificationReadState.unread) {
                        // Create notification
                        self.postNotification(notification: notification)
                    } else {
                        // Dismiss notification
                        self.dismissNotification(notificationId: notification.notificationId)
                    }
                } else {
                    print("Notification \(notification.notificationId) is deleted")
                    // Dismiss notification
                    self.dismissNotification(notificationId: notification.notificationId)
                }
            })
        })
    }

    // Display a notification on the device
    private func postNotification(notification: MCDUserNotification) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Flight Schedule"
        notificationContent.body = notification.content
        print("Notification body: \(notification.content)")

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: notification.notificationId, content: notificationContent, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: {
            (error: Error?) in
            if (error == nil) {
                print("Posted notification")
            } else {
                print("Error posting notification: \(error!)")
            }
        })
    }

    private func dismissNotification(notificationId: String) {
        print("Dismissing notification")
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationId])
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [notificationId])
    }

    private func refresh() {
        // Clear stored notifications
        currentNotifications.removeAll()

        registerWithDeviceToken(deviceToken: registration.token)
    }
}
