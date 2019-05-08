//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

// @brief result of processing a notification
__attribute__((visibility("default")))
@interface MCDConnectedDevicesProcessNotificationOperation : NSObject
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

- (void)waitForCompletionAsync:(nonnull void (^)(NSError* _Nullable error))callback;

@property(nonatomic, readonly, getter=isConnectedDevicesNotification) BOOL connectedDevicesNotification;

@end
