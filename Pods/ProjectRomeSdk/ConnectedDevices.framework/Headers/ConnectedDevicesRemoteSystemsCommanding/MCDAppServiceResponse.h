//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

// clang-format off
#pragma once

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MCDAppServiceResponseStatus)
{
    MCDAppServiceResponseStatusSuccess = 0,
    MCDAppServiceResponseStatusFailure,
    MCDAppServiceResponseStatusResourceLimitsExceeded,
    MCDAppServiceResponseStatusUnknown,
    MCDAppServiceResponseStatusRemoteSystemUnavailable,
    MCDAppServiceResponseStatusMessageSizeTooLarge,
    MCDAppServiceResponseStatusAppServiceConnectionClosed
};

__attribute__((visibility("default")))
@interface MCDAppServiceResponse : NSObject
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@property(nonatomic, readonly, nonnull) NSDictionary* message;
@property(nonatomic, readonly) MCDAppServiceResponseStatus status;
@end