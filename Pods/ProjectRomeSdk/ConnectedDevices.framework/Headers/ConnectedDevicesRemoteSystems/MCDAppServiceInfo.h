//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

// clang-format off
__attribute__((visibility("default"))) 
@interface MCDAppServiceInfo : NSObject<NSCopying> 

- (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

+ (nullable instancetype)infoWithName:(nonnull NSString*)name;
- (nullable instancetype)initWithName:(nonnull NSString*)name;

+ (nullable instancetype)infoWithName:(nonnull NSString*)name packageId:(nonnull NSString*)packageId;
- (nullable instancetype)initWithName:(nonnull NSString*)name packageId:(nonnull NSString*)packageId;

@property(nonatomic, readonly, nullable) NSString* name;
@property(nonatomic, readonly, nullable) NSString* packageId;
@end
