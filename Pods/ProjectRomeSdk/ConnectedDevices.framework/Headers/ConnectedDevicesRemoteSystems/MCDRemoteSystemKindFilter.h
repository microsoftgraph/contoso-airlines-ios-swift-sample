//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>
#import <ConnectedDevicesRemoteSystems/MCDRemoteSystemFilter.h>

// clang-format off
__attribute__((visibility("default")))
@interface MCDRemoteSystemKindFilter : NSObject<MCDRemoteSystemFilter>
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

+ (nullable instancetype)filterWithKinds:(nonnull NSArray<NSString*>*)kinds;
- (nullable instancetype)initWithKinds:(nonnull NSArray<NSString*>*)kinds;

@property(nonatomic, readonly, copy, nonnull) NSArray<NSString*>* kinds;

@end
