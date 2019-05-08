//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MCDRemoteSystemStatus)
{
    MCDRemoteSystemStatusUnavailable = 0,
    MCDRemoteSystemStatusDiscoveringAvailablilty,
    MCDRemoteSystemStatusAvailable,
    MCDRemoteSystemStatusUnknown
};

typedef NS_ENUM(NSInteger, MCDRemoteSystemPlatform)
{
    MCDRemoteSystemPlatformUnknown = 0,
    MCDRemoteSystemPlatformWindows,
    MCDRemoteSystemPlatformAndroid,
    MCDRemoteSystemPlatformIOS,
    MCDRemoteSystemPlatformLinux
};

@class MCDRemoteSystemApp;

// clang-format off
__attribute__((visibility("default")))
@interface MCDRemoteSystem : NSObject
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;
// clang-format on

@property(nonatomic, readonly, nonnull) NSString* kind;
@property(nonatomic, readonly, nonnull) NSString* systemId;
@property(nonatomic, readonly, nonnull) NSString* displayName;
@property(nonatomic, readonly) MCDRemoteSystemStatus status;
@property(nonatomic, readonly, nonnull) NSString* manufacturerDisplayName;
@property(nonatomic, readonly, nonnull) NSString* modelDisplayName;
@property(nonatomic, readonly, nonnull) NSArray<MCDRemoteSystemApp*>* apps;
@property(nonatomic, readonly) MCDRemoteSystemPlatform platform;

@end
