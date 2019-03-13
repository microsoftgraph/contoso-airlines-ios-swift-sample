//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

// @brief state of a RemoteSystemAppRegistration
typedef NS_ENUM(NSUInteger, MCDConnectedDevicesNotificationRegistrationState)
{
    MCDConnectedDevicesNotificationRegistrationStateUnregistered = 0,
    MCDConnectedDevicesNotificationRegistrationStateRegistered,
    MCDConnectedDevicesNotificationRegistrationStateExpiring,
    MCDConnectedDevicesNotificationRegistrationStateExpired
};
