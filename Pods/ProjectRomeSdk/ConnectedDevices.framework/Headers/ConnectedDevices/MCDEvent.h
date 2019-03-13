//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

// clang-format off
__attribute__((visibility("default")))
@interface MCDEventSubscription : NSObject
- (void)cancel;
@end

__attribute__((visibility("default")))
@interface MCDEvent<__covariant SourceType, __covariant ArgsType> : NSObject

- (nonnull MCDEventSubscription*)subscribe:(nonnull void (^)(SourceType _Nonnull, ArgsType _Nonnull))listener;

@end

