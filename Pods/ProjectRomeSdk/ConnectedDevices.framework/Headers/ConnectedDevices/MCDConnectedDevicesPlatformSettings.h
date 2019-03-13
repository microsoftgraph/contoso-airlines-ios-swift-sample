//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

// clang-format off
// @brief MCDConnectedDevicesPlatformSettings allows application developers to provide initial settings for the ConnectedDevices platform.
__attribute__((visibility("default")))
@interface MCDConnectedDevicesPlatformSettings : NSObject
+ (nullable instancetype) new;
- (nullable instancetype)init;

@property (nonatomic, readwrite, nonnull) NSString* storagePath;

@end
