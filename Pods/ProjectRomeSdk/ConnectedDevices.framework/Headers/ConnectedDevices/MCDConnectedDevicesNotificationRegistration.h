//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

// @brief type of notification
typedef NS_ENUM(NSInteger, MCDConnectedDevicesNotificationType)
{
    MCDNotificationTypeUnknown = 0,
    MCDNotificationTypeWNS,
    MCDNotificationTypeGCM,
    MCDNotificationTypeFCM,
    MCDNotificationTypeAPN,
    MCDNotificationTypePolling
};

// clang-format off
// @brief represent a notification registration
__attribute__((visibility("default"))) 
@interface MCDConnectedDevicesNotificationRegistration : NSObject

@property(nonatomic, readwrite) MCDConnectedDevicesNotificationType type;
@property(nonatomic, readwrite, nonnull) NSString* token;
@property(nonatomic, readwrite, nonnull) NSString* appId;
@property(nonatomic, readwrite, nonnull) NSString* appDisplayName;

@end
