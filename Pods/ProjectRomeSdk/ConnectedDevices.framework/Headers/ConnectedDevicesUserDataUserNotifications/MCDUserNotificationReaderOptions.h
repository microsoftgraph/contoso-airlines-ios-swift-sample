//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

// @brief Enum for start position of the reader
typedef NS_ENUM(NSInteger, MCDUserNotificationReaderStartPosition)
{
    MCDUserNotificationReaderStartPositionBeginning = 0,
    MCDUserNotificationReaderStartPositionEnd
};

// @brief Enum for status of notifications requested
typedef NS_ENUM(NSInteger, MCDUserNotificationStatusFilter)
{
    MCDUserNotificationStatusFilterAny = 0,
    MCDUserNotificationStatusFilterActive,
    MCDUserNotificationStatusFilterDeleted
};

// @brief Enum for state of notifications requested
typedef NS_ENUM(NSInteger, MCDUserNotificationReadStateFilter)
{
    MCDUserNotificationReadStateFilterAny = 0,
    MCDUserNotificationReadStateFilterUnread,
    MCDUserNotificationReadStateFilterRead
};

// @brief Enum for state of notifications requested
typedef NS_ENUM(NSInteger, MCDUserNotificationUserActionStateFilter)
{
    MCDUserNotificationUserActionStateFilterAny = 0,
    MCDUserNotificationUserActionStateFilterNoInteraction,
    MCDUserNotificationUserActionStateFilterActivated,
    MCDUserNotificationUserActionStateFilterDismissed,
    MCDUserNotificationUserActionStateFilterSnoozed
};

// clang-format off
// @brief Options for creating a MCDUserNotificationReader
__attribute__((visibility("default"))) 
@interface MCDUserNotificationReaderOptions : NSObject

// @brief Factory method
+ (nullable instancetype)options;

// @brief Get the start position
@property(nonatomic, assign) MCDUserNotificationReaderStartPosition startPosition;
// @brief Get the filter for status
@property(nonatomic, assign) MCDUserNotificationStatusFilter statusFilter;
// @brief Get the filter for read state
@property(nonatomic, assign) MCDUserNotificationReadStateFilter readStateFilter;
// @brief Get the filter for user action state
@property(nonatomic, assign) MCDUserNotificationUserActionStateFilter userActionStateFilter;
@end
