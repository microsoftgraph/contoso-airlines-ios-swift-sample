//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

#import <ConnectedDevicesUserData/MCDUserDataFeed.h>
#import <ConnectedDevicesUserData/MCDUserDataFeedSyncScope.h>
#import <ConnectedDevicesUserDataUserNotifications/MCDUserNotification.h>
#import <ConnectedDevicesUserDataUserNotifications/MCDUserNotificationReader.h>
#import <ConnectedDevicesUserDataUserNotifications/MCDUserNotificationReaderOptions.h>
#import <ConnectedDevicesUserDataUserNotifications/MCDUserNotificationUpdateResult.h>

// @brief The IUserNotificationChannel, which is backed by AFS.
// This store will manage the life cycle of the UserNotifications.
// clang-format off
__attribute__((visibility("default"))) 
@interface MCDUserNotificationChannel : NSObject 

+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

// @brief Factory method for creating Channel with a feed
+ (nullable instancetype)channelWithUserDataFeed:(nonnull MCDUserDataFeed*)userDataFeed;

// @brief Initalizer method for creating Channel with a feed.
- (nullable instancetype)initWithUserDataFeed:(nonnull MCDUserDataFeed*)userDataFeed;

// @breif SyncScope used to ensure UserNotifications are included in the feed.
@property(class, readonly, nonnull) id<MCDUserDataFeedSyncScope> syncScope;

// @brief Create reader to read all user notifications with default options
// If the store is unable to sync from user notification service, the stored offline notifications will be returned.
- (MCDUserNotificationReader* _Nullable)createReader;

// @brief Create reader to read user notifications with specified options
// @param options Options for creating the reader, namely start position and filters
- (MCDUserNotificationReader* _Nullable)createReaderWithOptions:(nonnull MCDUserNotificationReaderOptions*)options;

// @brief Create reader at specified state to read user notifications
// @param readerState Determines the state of the reader, to allow reader to start from an advanced position.
- (MCDUserNotificationReader* _Nullable)createReaderWithState:(nonnull NSString*)readerState;

// @brief Obtain the UserNotification object associated with the notification Id
- (void)getUserNotificationAsync:(nonnull NSString*)notificationId
                      completion:(nonnull void (^)(MCDUserNotification* _Nullable, NSError* _Nullable))completion;

// @brief Delete a notification corresponding to the notificationId parameter
// If we are unable to send the delete to UserNotification service (e.g connectivity lost), we will attempt to send it when we are able
// to contact UserNotification service. When the delete is being sent to the UserNotification service after being deferred, any errors
// will be communicated via callback.
- (void)deleteUserNotificationAsync:(NSString* _Nonnull)notificationId
                         completion:(nonnull void (^)(MCDUserNotificationUpdateResult* _Nullable, NSError* _Nullable))completion;
@end
