//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

@class MCDUserActivitySession;
@class MCDUserActivityContentInfo;
@class MCDUserActivityVisualElements;

typedef NS_ENUM(NSInteger, MCDUserActivityState)
{
    MCDUserActivityStateNew = 0,
    MCDUserActivityStatePublished
};

// clang-format off
__attribute__((visibility("default")))
@interface MCDUserActivity : NSObject
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

- (nullable instancetype)initWithActivityId:(nonnull NSString*)activityId;
+ (nullable instancetype)activityWithActivityId:(nonnull NSString*)activityId;

- (nonnull MCDUserActivitySession*)createSession;
- (void)saveAsync:(nonnull void (^)(NSError* _Nullable))completionBlock;

@property(nonatomic, readonly, nonnull) NSString* activityId;
@property(nonatomic, readonly) MCDUserActivityState state;
@property(nonatomic, copy, nonnull) NSString* activationUri;
@property(nonatomic, copy, nullable) NSString* fallbackUri;
@property(nonatomic, copy, nullable) NSString* contentUri;
@property(nonatomic, copy, nullable) NSString* contentType;
@property(nonatomic, copy, nullable) NSString* contentInfoJson;
@property(nonatomic, readonly, nullable) NSString* appDisplayName;
@property(nonatomic, retain, nonnull) MCDUserActivityVisualElements* visualElements;
@property(nonatomic, assign, getter = isRoamable) BOOL roamable;

@end
