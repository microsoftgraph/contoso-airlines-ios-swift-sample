//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

// @brief remote system watcher errors
// Used for communicating errors during discovery
typedef NS_ENUM(NSInteger, MCDRemoteSystemWatcherError)
{
    MCDRemoteSystemWatcherErrorUnknown = 0,
    MCDRemoteSystemWatcherErrorInternetNotAvailable,
    MCDRemoteSystemWatcherErrorAuthenticationError
};

// clang-format off
__attribute__((visibility("default")))
@interface MCDRemoteSystemWatcherErrorOccurredEventArgs : NSObject
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@property(nonatomic, readonly) MCDRemoteSystemWatcherError error;
@end
