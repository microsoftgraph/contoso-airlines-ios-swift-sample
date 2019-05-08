//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>
#import <ConnectedDevices/MCDConnectedDevicesAccount.h>

// clang-format off
// @brief MCDConnectedDevicesAccessTokenInvalidatedEventArgs are the event args used for invalidated token requests
__attribute__((visibility("default"))) 
@interface MCDConnectedDevicesAccessTokenInvalidatedEventArgs : NSObject 

+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@property(nonatomic, readonly, nonnull) MCDConnectedDevicesAccount* account;
@property(nonatomic, readonly, nonnull) NSArray<NSString*>* scopes;

@end
