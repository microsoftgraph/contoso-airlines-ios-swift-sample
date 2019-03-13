//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

// clang-format off
__attribute__((visibility("default")))
@interface MCDUserActivityAttribution : NSObject
- (nullable instancetype)init;

- (nullable instancetype)initWithIconUri:(nonnull NSString*)iconUri;
+ (nullable instancetype)attributionWithIconUri:(nonnull NSString*)iconUri;

@property(nonatomic, copy, nonnull) NSString* iconUri;
@property(nonatomic, copy, nonnull) NSString* alternateText;
@property(nonatomic, assign) BOOL addImageQuery;

@end
