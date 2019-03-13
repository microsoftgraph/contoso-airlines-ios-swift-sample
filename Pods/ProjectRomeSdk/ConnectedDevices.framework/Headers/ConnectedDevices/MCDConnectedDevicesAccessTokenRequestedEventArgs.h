//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>
#import <ConnectedDevices/MCDConnectedDevicesAccount.h>
#import <ConnectedDevices/MCDConnectedDevicesAccessTokenRequest.h>

// clang-format off
// @brief MCDConnectedDevicesAccessTokenRequestedEventArgs are the event args used for token requests
__attribute__((visibility("default"))) 
@interface MCDConnectedDevicesAccessTokenRequestedEventArgs : NSObject 

+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@property(nonatomic, readonly, nonnull) MCDConnectedDevicesAccessTokenRequest* request;

@end
