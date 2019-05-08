//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>
#import <ConnectedDevices/MCDEvent.h>
#import <ConnectedDevicesUserData/MCDUserDataFeedSyncScope.h>
#import <ConnectedDevices/MCDConnectedDevicesNotificationRegistration.h>

@class MCDConnectedDevicesAccount;
@class MCDConnectedDevicesPlatform;

typedef NS_ENUM(NSInteger, MCDUserDataFeedSyncStatus)
{
    MCDUserDataFeedSyncStatusQueued = 0,
    MCDUserDataFeedSyncStatusSynchronized,
};

// clang-format off
__attribute__((visibility("default")))
@interface MCDUserDataFeedSyncStatusChangedEventArgs : NSObject
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;
@end

__attribute__((visibility("default")))
@interface MCDUserDataFeed : NSObject
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

+ (nullable instancetype)getForAccount:(nonnull MCDConnectedDevicesAccount*)account
                                   platform:(nonnull MCDConnectedDevicesPlatform*)platform
                         activitySourceHost:(nonnull NSString*)activitySourceHost;

- (void)subscribeToSyncScopesAsync:(NSArray<id<MCDUserDataFeedSyncScope>>* _Nonnull) syncScopes callback:(nonnull void (^)(BOOL, NSError* _Nullable)) callback;

- (void)startSync;

@property(nonatomic, readwrite) NSInteger daysToSync;
@property(nonatomic, readonly, nonnull) MCDEvent<MCDUserDataFeed*, MCDUserDataFeedSyncStatusChangedEventArgs*>* syncStatusChanged;
@property(nonatomic, readonly) MCDUserDataFeedSyncStatus syncStatus;

@end
