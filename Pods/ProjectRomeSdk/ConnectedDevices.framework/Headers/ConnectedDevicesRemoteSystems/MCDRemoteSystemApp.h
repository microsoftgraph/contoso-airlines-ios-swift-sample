//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

@class MCDAppServiceInfo;
@class MCDConnectedDevicesAccount;

// clang-format off
__attribute__((visibility("default")))
@interface MCDRemoteSystemApp : NSObject
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;
// clang-format on

@property(nonatomic, readonly, nonnull) NSString* appId;
@property(nonatomic, readonly, nonnull) NSString* displayName;

@property(nonatomic, readonly, getter=isAvailableByProximity) BOOL availableByProximity;
@property(nonatomic, readonly, getter=isAvailableBySpatialProximity) BOOL availableBySpatialProximity;

@property(nonatomic, readonly, nonnull) NSDictionary<NSString*, NSString*>* attributes;
@property(nonatomic, readonly, nullable) NSArray<MCDAppServiceInfo*>* appServices;
@property(nonatomic, readonly, nullable) NSArray<MCDConnectedDevicesAccount*>* accounts;
@end
