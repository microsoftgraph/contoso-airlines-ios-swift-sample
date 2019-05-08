//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>
#import "MCDConnectedDevicesAccountManager.h"
#import "MCDConnectedDevicesNotificationRegistrationManager.h"
#import "MCDConnectedDevicesProcessNotificationOperation.h"
#import "MCDConnectedDevicesPlatformSettings.h"

// clang-format off
// @brief MCDConnectedDevicesPlatform represents the basic entrypoint into the Connected Devices Platform.
__attribute__((visibility("default")))
@interface MCDConnectedDevicesPlatform : NSObject
+ (nullable instancetype) new;
- (nullable instancetype)init;

+ (nullable instancetype)platformWithSettings:(MCDConnectedDevicesPlatformSettings* _Nonnull)settings;
- (nullable instancetype)initWithSettings:(MCDConnectedDevicesPlatformSettings* _Nonnull)settings;

- (void) start;
- (void)shutdownAsync:(void (^_Nonnull)(NSError* _Nullable))completionBlock;
- (MCDConnectedDevicesProcessNotificationOperation* _Nonnull)processNotification:(NSDictionary* _Nonnull)notification;

@property(nonatomic, readonly, nonnull) MCDConnectedDevicesAccountManager* accountManager;
@property(nonatomic, readonly, nonnull) MCDConnectedDevicesNotificationRegistrationManager* notificationRegistrationManager;

@end
