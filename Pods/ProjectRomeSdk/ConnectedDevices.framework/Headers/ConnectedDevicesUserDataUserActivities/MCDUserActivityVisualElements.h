//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKitBase.h>

@class MCDUserActivityAttribution;

// clang-format off
__attribute__((visibility("default")))
@interface MCDUserActivityVisualElements : NSObject 
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@property(nonatomic, copy, nonnull) NSString* displayText;
@property(nonatomic, copy, nullable) NSString* descriptionText;
@property(nonatomic, copy, nullable) SKColor* backgroundColor;
@property(nonatomic, retain, nullable) MCDUserActivityAttribution* attribution;
@property(nonatomic, copy, nullable) NSString* adaptiveCardJson;
@property(nonatomic, copy, nullable) NSString* attributionDisplayText;

@end
