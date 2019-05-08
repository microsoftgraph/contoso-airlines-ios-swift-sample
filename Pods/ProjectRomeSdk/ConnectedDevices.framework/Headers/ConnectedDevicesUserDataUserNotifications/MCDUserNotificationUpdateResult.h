//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

// @brief The user notification callback status for the async callback
// clang-format off
__attribute__((visibility("default"))) 
@interface MCDUserNotificationUpdateResult : NSObject 
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

// @brief Get the notificationId
@property(nonatomic, readonly, nonnull) NSString* notificationId;
// @brief The result status for the operation
@property(nonatomic, readonly) BOOL succeeded;
@end
