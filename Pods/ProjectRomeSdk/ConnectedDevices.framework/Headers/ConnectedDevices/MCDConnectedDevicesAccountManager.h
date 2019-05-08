//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>
#import "MCDConnectedDevicesAccount.h"
#import "MCDConnectedDevicesAddAccountResult.h"
#import "MCDConnectedDevicesRemoveAccountResult.h"
#import "MCDConnectedDevicesAccessTokenRequestedEventArgs.h"
#import "MCDConnectedDevicesAccessTokenInvalidatedEventArgs.h"
#import <ConnectedDevices/MCDEvent.h>

// clang-format off
// @bief IConnectedDevicesAccountManager provides a single entrypoint for all account-related features in the OneSDK.
__attribute__((visibility("default"))) 
@interface MCDConnectedDevicesAccountManager : NSObject 

+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

- (void) addAccountAsync:(MCDConnectedDevicesAccount* _Nonnull)account callback:(nonnull void (^)(MCDConnectedDevicesAddAccountResult* _Nullable, NSError* _Nullable))callback;
- (void) removeAccountAsync:(MCDConnectedDevicesAccount* _Nonnull)account callback:(nonnull void (^)(MCDConnectedDevicesRemoveAccountResult* _Nullable, NSError* _Nullable))callback;

@property(nonatomic, readonly, nonnull) MCDEvent<MCDConnectedDevicesAccountManager*, MCDConnectedDevicesAccessTokenRequestedEventArgs*>* accessTokenRequested;
@property(nonatomic, readonly, nonnull) MCDEvent<MCDConnectedDevicesAccountManager*, MCDConnectedDevicesAccessTokenInvalidatedEventArgs*>* accessTokenInvalidated;
@property(nonatomic, readonly, nonnull) NSArray<MCDConnectedDevicesAccount*>* accounts;

@end
