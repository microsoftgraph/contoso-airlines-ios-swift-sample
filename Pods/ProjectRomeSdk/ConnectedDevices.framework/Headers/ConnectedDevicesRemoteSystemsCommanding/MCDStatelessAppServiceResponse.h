//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

// clang-format off
#pragma once

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MCDStatelessAppServiceResponseStatus)
{
    MCDStatelessAppServiceResponseStatusSuccess = 0,
    MCDStatelessAppServiceResponseStatusAppNotInstalled,
    MCDStatelessAppServiceResponseStatusAppUnavailable,
    MCDStatelessAppServiceResponseStatusAppServiceUnavailable,
    MCDStatelessAppServiceResponseStatusRemoteSystemUnavailable,
    MCDStatelessAppServiceResponseStatusRemoteSystemNotSupportedByApp,
    MCDStatelessAppServiceResponseStatusNotAuthorized,
    MCDStatelessAppServiceResponseStatusResourceLimitsExceeded,
    MCDStatelessAppServiceResponseStatusMessageSizeTooLarge,
    MCDStatelessAppServiceResponseStatusFailure,
    MCDStatelessAppServiceResponseStatusUnknown
};

__attribute__((visibility("default")))
@interface MCDStatelessAppServiceResponse : NSObject
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@property(nonatomic, readonly, nonnull) NSDictionary* message;
@property(nonatomic, readonly) MCDStatelessAppServiceResponseStatus status;
@end
