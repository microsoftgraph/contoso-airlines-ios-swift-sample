//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>
#import <ConnectedDevicesRemoteSystems/MCDRemoteSystem.h>
#import <ConnectedDevicesRemoteSystems/MCDRemoteSystemFilter.h>

// clang-format off
__attribute__((visibility("default"))) 
@interface MCDRemoteSystemPlatformFilter : NSObject<MCDRemoteSystemFilter> 
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

+ (nullable instancetype)filterWithPlatform:(MCDRemoteSystemPlatform)platform;
- (nullable instancetype)initWithPlatform:(MCDRemoteSystemPlatform)platform;

@property(nonatomic, readonly) MCDRemoteSystemPlatform platform;

@end
