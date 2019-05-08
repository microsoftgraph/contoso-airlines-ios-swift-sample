//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

// clang-format off
__attribute__((visibility("default"))) 
@interface MCDRemoteSystemKinds : NSObject 

+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@property(class, readonly, nonnull) NSString* desktop;
@property(class, readonly, nonnull) NSString* holographic;
@property(class, readonly, nonnull) NSString* hub;
@property(class, readonly, nonnull) NSString* phone;
@property(class, readonly, nonnull) NSString* xbox;
@property(class, readonly, nonnull) NSString* laptop;
@property(class, readonly, nonnull) NSString* iot;
@property(class, readonly, nonnull) NSString* tablet;
@end
