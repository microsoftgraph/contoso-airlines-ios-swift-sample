//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>
#import <ConnectedDevicesRemoteSystems/MCDRemoteSystemFilter.h>

// @brief Type of remote system discovery
// Used for filtering remote systems during discovery
typedef NS_ENUM(NSInteger, MCDRemoteSystemDiscoveryType)
{
    MCDRemoteSystemDiscoveryTypeAny = 0,
    MCDRemoteSystemDiscoveryTypeProximal,
    MCDRemoteSystemDiscoveryTypeCloud,
    MCDRemoteSystemDiscoveryTypeSpatiallyProximal
};

// clang-format off
__attribute__((visibility("default")))
@interface MCDRemoteSystemDiscoveryTypeFilter : NSObject<MCDRemoteSystemFilter>
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

+ (nullable instancetype)filterWithType:(MCDRemoteSystemDiscoveryType)discoveryType;
- (nullable instancetype)initWithType:(MCDRemoteSystemDiscoveryType)discoveryType;

@property(nonatomic, readonly) MCDRemoteSystemDiscoveryType type;
@end
