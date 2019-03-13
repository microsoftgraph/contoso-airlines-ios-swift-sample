//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>
#import "MCDConnectedDevicesAccount.h"
#import "MCDConnectedDevicesNotificationRegistration.h"
#import "MCDConnectedDevicesNotificationRegistrationState.h"
#import <ConnectedDevices/MCDEvent.h>

// clang-format off
// @bief IConnectedDevicesAccountManager provides a single entrypoint for all account-related features in the OneSDK.
__attribute__((visibility("default"))) 
@interface MCDConnectedDevicesNotificationRegistrationStateChangedEventArgs : NSObject

+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@property(nonatomic, readonly, nonnull) MCDConnectedDevicesAccount* account;
@property(nonatomic, readonly, nonnull) MCDConnectedDevicesNotificationRegistration* registration;
@property(nonatomic, readonly) MCDConnectedDevicesNotificationRegistrationState state;

@end
