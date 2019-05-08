//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>
#import <ConnectedDevicesRemoteSystems/MCDRemoteSystem.h>

// clang-format off
__attribute__((visibility("default")))
@interface MCDRemoteSystemUpdatedEventArgs : NSObject
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@property(nonatomic, readonly, nonnull) MCDRemoteSystem* remoteSystem;
@end
