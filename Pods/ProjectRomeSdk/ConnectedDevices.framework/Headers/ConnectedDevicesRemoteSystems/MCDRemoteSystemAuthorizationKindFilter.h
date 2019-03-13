//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>
#import <ConnectedDevicesRemoteSystems/MCDRemoteSystemFilter.h>

// @brief Authorization / owner of remote system
typedef NS_ENUM(NSInteger, MCDRemoteSystemAuthorizationKind)
{
    MCDRemoteSystemAuthorizationKindSameUser = 0,
    MCDRemoteSystemAuthorizationKindAnonymous
};

// clang-format off
__attribute__((visibility("default")))
@interface MCDRemoteSystemAuthorizationKindFilter : NSObject<MCDRemoteSystemFilter>
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

+ (nullable instancetype)filterWithKind:(MCDRemoteSystemAuthorizationKind)authorizationKind;
- (nullable instancetype)initWithKind:(MCDRemoteSystemAuthorizationKind)authorizationKind;

@property(nonatomic, readonly) MCDRemoteSystemAuthorizationKind kind;

@end
