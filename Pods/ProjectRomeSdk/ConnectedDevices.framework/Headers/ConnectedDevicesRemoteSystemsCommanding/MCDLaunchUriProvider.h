//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>
#import <ConnectedDevicesRemoteSystemsCommanding/MCDRemoteLauncherOptions.h>

// clang-format off
__attribute__((visibility("default")))
@protocol MCDLaunchUriProvider <NSObject>
- (void)onLaunchUriAsync:(nonnull NSString*)uri
                 options:(nullable MCDRemoteLauncherOptions*)options
              completion:(nonnull void (^)(BOOL, NSError* _Nullable))completionBlock;
@property(nonatomic, readonly, strong, nullable) NSArray<NSString*>* supportedUriSchemes;
@end