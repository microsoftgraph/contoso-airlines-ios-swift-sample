//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

// @brief The type of the MCDConnectedDevicesAccount.
typedef NS_ENUM(NSInteger, MCDConnectedDevicesAccountType)
{
    MCDConnectedDevicesAccountTypeAAD = 0,  // Azure Active Directory Workplace Account
    MCDConnectedDevicesAccountTypeMSA,      // Microsoft Personal Account
    MCDConnectedDevicesAccountTypeAnonymous // Anonymous (local, non-authenticated) Account
};

// clang-format off
// @brief MCDConnectedDevicesAccount is the result of a successful user sign in.
__attribute__((visibility("default"))) 
@interface MCDConnectedDevicesAccount : NSObject 

+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

+ (nullable instancetype)accountWithAccountId:(NSString* _Nonnull)accountId type:(MCDConnectedDevicesAccountType)type;
- (nullable instancetype)initWithAccountId:(NSString* _Nonnull)accountId type:(MCDConnectedDevicesAccountType)type;

@property(class, nonatomic, readonly, nullable) MCDConnectedDevicesAccount* anonymousAccount;

@property(nonatomic, readonly, copy, nonnull) NSString* accountId;
@property(nonatomic, readonly) MCDConnectedDevicesAccountType type;

@end
