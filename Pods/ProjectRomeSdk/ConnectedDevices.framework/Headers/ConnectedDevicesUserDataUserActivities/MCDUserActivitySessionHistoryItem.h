//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

@class MCDUserActivity;

// clang-format off
__attribute__((visibility("default")))
@interface MCDUserActivitySessionHistoryItem : NSObject
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@property(nonatomic, readonly, nonnull) MCDUserActivity* userActivity;
@property(nonatomic, readonly, nonnull) NSDate* startTime;
@property(nonatomic, readonly, nullable) NSDate* endTime;
@property(nonatomic, readonly, nullable) NSString* remoteSystemId;

@end
