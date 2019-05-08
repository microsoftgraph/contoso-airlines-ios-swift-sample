//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>
#import <ConnectedDevicesRemoteSystems/MCDRemoteSystemFilter.h>

typedef NS_ENUM(NSInteger, MCDRemoteSystemLocalVisibilityKind)
{
    MCDRemoteSystemLocalVisibilityKindShowAll = 0,
    MCDRemoteSystemLocalVisibilityKindHideLocalApp
};

// clang-format off
__attribute__((visibility("default")))
@interface MCDRemoteSystemLocalVisibilityKindFilter : NSObject<MCDRemoteSystemFilter>
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

+ (nullable instancetype)filterWithKind:(MCDRemoteSystemLocalVisibilityKind)localVisibilityKind;
- (nullable instancetype)initWithKind:(MCDRemoteSystemLocalVisibilityKind)localVisibilityKind;

@property(nonatomic, readonly) MCDRemoteSystemLocalVisibilityKind kind;

@end
