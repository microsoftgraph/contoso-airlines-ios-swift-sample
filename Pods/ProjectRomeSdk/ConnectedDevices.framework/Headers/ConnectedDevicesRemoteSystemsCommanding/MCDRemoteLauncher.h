//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

#import <ConnectedDevicesRemoteSystemsCommanding/MCDRemoteLauncherOptions.h>
#import <ConnectedDevicesRemoteSystemsCommanding/MCDRemoteSystemConnectionRequest.h>

// @brief Status of a URI launch
typedef NS_ENUM(NSInteger, MCDRemoteLaunchUriStatus)
{
    MCDRemoteLaunchUriStatusUnknown = 0,
    MCDRemoteLaunchUriStatusSuccess,
    MCDRemoteLaunchUriStatusAppUnavailable,
    MCDRemoteLaunchUriStatusProtocolUnavailable,
    MCDRemoteLaunchUriStatusRemoteSystemUnavailable,
    MCDRemoteLaunchUriStatusValueSetTooLarge,
    MCDRemoteLaunchUriStatusDeniedByLocalSystem,
    MCDRemoteLaunchUriStatusDeniedByRemoteSystem
};

// clang-format off
__attribute__((visibility("default")))
@interface MCDRemoteLauncher : NSObject

- (void)launchUriAsync:(nonnull NSString*)uri
 withConnectionRequest:(nonnull MCDRemoteSystemConnectionRequest*)connection
            completion:(nullable void (^)(MCDRemoteLaunchUriStatus result, NSError* _Nullable error))completionBlock;

- (void)launchUriAsync:(nonnull NSString*)uri
 withConnectionRequest:(nonnull MCDRemoteSystemConnectionRequest*)connection
               options:(nullable MCDRemoteLauncherOptions*)options
            completion:(nullable void (^)(MCDRemoteLaunchUriStatus result, NSError* _Nullable error))completionBlock;

@end