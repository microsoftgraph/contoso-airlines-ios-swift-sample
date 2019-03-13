//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/NSObject.h>
#import <ConnectedDevicesRemoteSystemsCommanding/MCDAppServiceConnection.h>
#import <ConnectedDevicesRemoteSystems/MCDRemoteSystemApp.h>

// clang-format off
__attribute__((visibility("default")))
@interface MCDAppServiceConnectionOpenedInfo : NSObject
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@property(nonatomic, readonly, nonnull) MCDAppServiceConnection* appServiceConnection;
@property(nonatomic, readonly, nullable) MCDRemoteSystemApp* remoteSystemApp;
@end
