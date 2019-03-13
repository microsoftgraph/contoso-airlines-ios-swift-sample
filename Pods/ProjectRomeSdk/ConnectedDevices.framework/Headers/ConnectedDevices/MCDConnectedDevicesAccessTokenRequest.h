//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>
#import <ConnectedDevices/MCDConnectedDevicesAccount.h>

// clang-format off
// @brief MCDConnectedDevicesAccessTokenRequest is the request to fetch an access token.
__attribute__((visibility("default")))
@interface MCDConnectedDevicesAccessTokenRequest : NSObject

+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

- (void) completeWithAccessToken:(NSString* _Nonnull) token;
- (void) completeWithErrorMessage:(NSString* _Nullable) errorMessage;

@property(nonatomic, readonly, nonnull) NSArray<NSString*>* scopes;
@property(nonatomic, readonly, nonnull) MCDConnectedDevicesAccount* account;

@end
