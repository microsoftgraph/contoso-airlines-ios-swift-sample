//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/NSObject.h>
#import <ConnectedDevicesRemoteSystems/MCDAppServiceInfo.h>

@class MCDAppServiceConnectionOpenedInfo;

// clang-format off
__attribute__((visibility("default"))) 
@protocol MCDAppServiceProvider<NSObject> 

- (void)connectionDidOpen:(nonnull MCDAppServiceConnectionOpenedInfo*)openedInfo;

@property(nonatomic, readonly, strong, nonnull) MCDAppServiceInfo* appServiceInfo;

@end
