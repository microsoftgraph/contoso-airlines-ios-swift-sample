//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>
#import <ConnectedDevicesRemoteSystems/MCDRemoteSystemFilter.h>

@class MCDConnectedDevicesAccount;

// clang-format off
__attribute__((visibility("default")))
@interface MCDRemoteSystemAccountFilter : NSObject<MCDRemoteSystemFilter>
+ (nullable instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;
// clang-format on

+ (nullable instancetype)filterWithAccount:(nonnull MCDConnectedDevicesAccount*)account;
- (nullable instancetype)initWithAccount:(nonnull MCDConnectedDevicesAccount*)account;

@property(nonatomic, readonly, strong, nonnull) MCDConnectedDevicesAccount* account;

@end
