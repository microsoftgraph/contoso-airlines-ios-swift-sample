//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>
#import <ConnectedDevicesRemoteSystems/MCDRemoteSystemFilter.h>

// @brief Type of remote system status
// Used for filtering remote systems during discovery
typedef NS_ENUM(NSInteger, MCDRemoteSystemStatusType)
{
    MCDRemoteSystemStatusTypeAny = 0,
    MCDRemoteSystemStatusTypeAvailable
};

// clang-format off
__attribute__((visibility("default")))
@interface MCDRemoteSystemStatusTypeFilter : NSObject<MCDRemoteSystemFilter>
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

+ (nullable instancetype)filterWithType:(MCDRemoteSystemStatusType)statusType;
- (nullable instancetype)initWithType:(MCDRemoteSystemStatusType)statusType;

@property(nonatomic, readonly) MCDRemoteSystemStatusType type;

@end
