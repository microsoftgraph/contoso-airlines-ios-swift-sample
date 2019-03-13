//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <ConnectedDevicesRemoteSystems/MCDRemoteSystem.h>
#import <ConnectedDevicesRemoteSystems/MCDRemoteSystemApp.h>

// clang-format off
__attribute__((visibility("default"))) 
@interface MCDRemoteSystemConnectionRequest : NSObject
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

+ (nullable instancetype)requestWithRemoteSystem:(nonnull MCDRemoteSystem*)remoteSystem;
+ (nullable instancetype)requestWithRemoteSystemApp:(nonnull MCDRemoteSystemApp*)remoteSystemApp;
- (nullable instancetype)initWithRemoteSystem:(nonnull MCDRemoteSystem*)remoteSystem;
- (nullable instancetype)initWithRemoteSystemApp:(nonnull MCDRemoteSystemApp*)remoteSystemApp;

@end
