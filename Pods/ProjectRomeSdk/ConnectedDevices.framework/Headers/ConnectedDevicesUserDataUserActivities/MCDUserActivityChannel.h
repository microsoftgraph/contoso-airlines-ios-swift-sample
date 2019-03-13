//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

#import <ConnectedDevicesUserData/MCDUserDataFeed.h>
#import <ConnectedDevicesUserData/MCDUserDataFeedSyncScope.h>
#import <ConnectedDevicesUserDataUserActivities/MCDUserActivity.h>
#import <ConnectedDevicesUserDataUserActivities/MCDUserActivitySessionHistoryItem.h>

// clang-format off
__attribute__((visibility("default")))
 @interface MCDUserActivityChannel : NSObject
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

+ (nullable instancetype)channelWithUserDataFeed:(nonnull MCDUserDataFeed*)userDataFeed;

@property(class, readonly, nonnull) id<MCDUserDataFeedSyncScope> syncScope;

- (void)getOrCreateUserActivityAsync:(nonnull NSString*)activityId
                          completion:(nonnull void (^)(MCDUserActivity* _Nonnull, NSError* _Nullable))completionBlock;
- (void)deleteActivityAsync:(nonnull NSString*)activityId completion:(nonnull void (^)(NSError* _Nullable))completionBlock;
- (void)deleteAllActivitiesAsync:(nonnull void (^)(NSError* _Nullable))completionBlock;
- (void)getRecentUserActivitiesAsync:(NSInteger)maxUniqueActivities
                          completion:
                              (void (^_Nonnull)(NSArray<MCDUserActivitySessionHistoryItem*>* _Nonnull, NSError* _Nullable))completionBlock;
- (void)getSessionHistoryItemsForUserActivityAsync:(nonnull NSString*)activityId
                                         startTime:(nonnull NSDate*)startTime
                                        completion:(void (^_Nonnull)(NSArray<MCDUserActivitySessionHistoryItem*>* _Nonnull,
                                                       NSError* _Nullable))completionBlock;

- (void)getRecentSessionHistoryItemsForTimeRangeAsync:(nonnull NSDate*)startTime
                                        endTime:(nonnull NSDate*)endTime
                                  maxActivities:(NSInteger)maxActivities
                                     completion:(void (^_Nonnull)(NSArray<MCDUserActivitySessionHistoryItem*>* _Nonnull,
                                                       NSError* _Nullable))completionBlock;

@property(nonatomic, copy, nullable) NSString* appDisplayName;
@end
