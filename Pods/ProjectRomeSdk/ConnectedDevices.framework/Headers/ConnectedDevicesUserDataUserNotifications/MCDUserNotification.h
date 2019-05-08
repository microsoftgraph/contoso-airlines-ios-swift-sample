//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

@class MCDUserNotificationUpdateResult;

// @brief Read status of a User Notification
typedef NS_ENUM(NSInteger, MCDUserNotificationReadState)
{
    MCDUserNotificationReadStateUnread = 0,
    MCDUserNotificationReadStateRead
};

// @brief User state of User Notification
typedef NS_ENUM(NSInteger, MCDUserNotificationUserActionState)
{
    MCDUserNotificationUserActionStateNoInteraction = 0,
    MCDUserNotificationUserActionStateActivated,
    MCDUserNotificationUserActionStateDismissed,
    MCDUserNotificationUserActionStateSnoozed
};

// @brief Status of the user notification
typedef NS_ENUM(NSInteger, MCDUserNotificationStatus)
{
    MCDUserNotificationStatusActive = 0,
    MCDUserNotificationStatusDeleted
};

// @brief Priority of the User Notification
typedef NS_ENUM(NSInteger, MCDUserNotificationPriority)
{
    MCDUserNotificationPriorityNone = 0,
    MCDUserNotificationPriorityHigh,
    MCDUserNotificationPriorityLow
};

// @brief User notification created by User's notification channel
// clang-format off
__attribute__((visibility("default"))) 
@interface MCDUserNotification : NSObject 
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

// @brief Get the ID
@property(nonatomic, readonly, nonnull) NSString* notificationId;
// @brief Get the group ID
@property(nonatomic, readonly, nonnull) NSString* groupId;
// @brief Get the expiration time
@property(nonatomic, readonly, nonnull) NSDate* expirationTime;
// @brief Get the status of change
@property(nonatomic, readonly) MCDUserNotificationStatus status;
// @brief Get the time the change was made
@property(nonatomic, readonly, nonnull) NSDate* changeTime;
// @brief Get the priority
@property(nonatomic, readonly) MCDUserNotificationPriority priority;
// @brief Get the content
@property(nonatomic, readonly, nonnull) NSString* content;

// @brief Get/Set read state
@property(nonatomic, assign, readwrite) MCDUserNotificationReadState readState;
// @brief Get/Set the user action state
@property(nonatomic, assign, readwrite) MCDUserNotificationUserActionState userActionState;

// @brief Save the notification
- (void)saveAsync:(nonnull void (^)(MCDUserNotificationUpdateResult* _Nullable, NSError* _Nullable))completion;
@end
