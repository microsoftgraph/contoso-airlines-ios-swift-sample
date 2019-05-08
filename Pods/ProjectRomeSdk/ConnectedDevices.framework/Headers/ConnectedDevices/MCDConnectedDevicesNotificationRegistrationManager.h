//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>
#import "MCDConnectedDevicesAccount.h"
#import "MCDConnectedDevicesNotificationRegistrationStateChangedEventArgs.h"
#import <ConnectedDevices/MCDEvent.h>

// clang-format off
// @bief IConnectedDevicesAccountManager provides a single entrypoint for all account-related features in the OneSDK.
__attribute__((visibility("default"))) 
@interface MCDConnectedDevicesNotificationRegistrationManager : NSObject

+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

- (void) registerForAccountAsync:(MCDConnectedDevicesAccount* _Nonnull) account registration:(MCDConnectedDevicesNotificationRegistration* _Nonnull) notificationRegistration callback:(nonnull void (^)(BOOL, NSError* _Nullable)) callback;
- (MCDConnectedDevicesNotificationRegistrationState) getNotificationRegistrationStateForAccount:(MCDConnectedDevicesAccount* _Nonnull)account;

@property(nonatomic, readonly, nonnull) MCDEvent<MCDConnectedDevicesNotificationRegistrationManager*, MCDConnectedDevicesNotificationRegistrationStateChangedEventArgs*>* notificationRegistrationStateChanged;

@end
