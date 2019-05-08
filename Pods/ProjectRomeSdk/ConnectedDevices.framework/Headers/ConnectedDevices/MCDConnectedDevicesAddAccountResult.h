//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MCDConnectedDevicesAccountAddedStatus)
{
    MCDConnectedDevicesAccountAddedStatusSuccess = 0,
    MCDConnectedDevicesAccountAddedStatusErrorNoNetwork,
    MCDConnectedDevicesAccountAddedStatusErrorServiceFailed,
    MCDConnectedDevicesAccountAddedStatusErrorNoTokenRequestSubscriber,
    MCDConnectedDevicesAccountAddedStatusErrorTokenRequestFailed,
    MCDConnectedDevicesAccountAddedStatusErrorUnknown
};

__attribute__((visibility("default")))
@interface MCDConnectedDevicesAddAccountResult : NSObject
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@property(nonatomic, readonly) MCDConnectedDevicesAccountAddedStatus status;
@end
