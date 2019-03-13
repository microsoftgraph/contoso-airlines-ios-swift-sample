//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>
#import <ConnectedDevices/MCDEvent.h>
#import <ConnectedDevicesRemoteSystems/MCDRemoteSystemAddedEventArgs.h>
#import <ConnectedDevicesRemoteSystems/MCDRemoteSystemEnumerationCompletedEventArgs.h>
#import <ConnectedDevicesRemoteSystems/MCDRemoteSystemFilter.h>
#import <ConnectedDevicesRemoteSystems/MCDRemoteSystemRemovedEventArgs.h>
#import <ConnectedDevicesRemoteSystems/MCDRemoteSystemUpdatedEventArgs.h>
#import <ConnectedDevicesRemoteSystems/MCDRemoteSystemWatcherErrorOccurredEventArgs.h>

// @brief MCDRemoteSystemWatcher is the result of a successful user sign in.
// clang-format off
__attribute__((visibility("default")))
@interface MCDRemoteSystemWatcher : NSObject

+ (nullable instancetype)watcher;
// clang-format on
+ (nullable instancetype)watcherWithFilters:(nonnull NSArray<NSObject<MCDRemoteSystemFilter>*>*)filters;
- (nullable instancetype)initWithFilters:(nonnull NSArray<NSObject<MCDRemoteSystemFilter>*>*)filters;

- (void)start;
- (void)stop;

@property(nonatomic, readonly, nonnull) MCDEvent<MCDRemoteSystemWatcher*, MCDRemoteSystemAddedEventArgs*>* remoteSystemAdded;
@property(nonatomic, readonly, nonnull) MCDEvent<MCDRemoteSystemWatcher*, MCDRemoteSystemUpdatedEventArgs*>* remoteSystemUpdated;
@property(nonatomic, readonly, nonnull) MCDEvent<MCDRemoteSystemWatcher*, MCDRemoteSystemRemovedEventArgs*>* remoteSystemRemoved;
@property(nonatomic, readonly, nonnull)
    MCDEvent<MCDRemoteSystemWatcher*, MCDRemoteSystemEnumerationCompletedEventArgs*>* enumerationCompleted;
@property(nonatomic, readonly, nonnull) MCDEvent<MCDRemoteSystemWatcher*, MCDRemoteSystemWatcherErrorOccurredEventArgs*>* errorOccurred;

@end
