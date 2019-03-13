//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>
#import <ConnectedDevices/MCDEvent.h>
#import <ConnectedDevices/MCDConnectedDevicesAccount.h>
#import <ConnectedDevices/MCDConnectedDevicesNotificationRegistration.h>
#import <ConnectedDevices/MCDConnectedDevicesPlatform.h>
#import <ConnectedDevicesRemoteSystemsCommanding/MCDAppServiceProvider.h>
#import <ConnectedDevicesRemoteSystemsCommanding/MCDLaunchUriProvider.h>

// clang-format off
__attribute__((visibility("default")))
@interface MCDRemoteSystemAppRegistration : NSObject

-(nullable instancetype) init NS_UNAVAILABLE;
-(nullable instancetype) new NS_UNAVAILABLE;

+(nullable instancetype) getForAccount:(MCDConnectedDevicesAccount* _Nonnull) account
                              platform:(MCDConnectedDevicesPlatform* _Nonnull) platform;

- (void)saveAsync:(nonnull void (^)(BOOL, NSError* _Nullable))callback;

@property(nonatomic, readonly, nullable) MCDConnectedDevicesAccount* account;
@property(nonatomic, copy, nullable) NSDictionary<NSString*, NSString*>* attributes;
@property(nonatomic, copy, nullable) NSArray<id<MCDAppServiceProvider>>* appServiceProviders;
@property(nonatomic, readwrite, nullable) id<MCDLaunchUriProvider> launchUriProvider;

@end
