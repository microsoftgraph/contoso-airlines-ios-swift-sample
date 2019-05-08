//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>
#import <ConnectedDevicesRemoteSystemsCommanding/MCDAppServiceResponse.h>

// clang-format off
__attribute__((visibility("default")))
@interface MCDAppServiceRequest : NSObject
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@property(nonatomic, readonly, nonnull) NSDictionary* message;

- (void)sendResponseAsync:(nonnull NSDictionary*)message
               completion:(nonnull void (^)(MCDAppServiceResponseStatus, NSError* _Nullable))completion;
@end
