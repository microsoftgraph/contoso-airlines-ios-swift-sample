//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>
#import <ConnectedDevices/MCDEvent.h>
#import <ConnectedDevicesRemoteSystems/MCDAppServiceInfo.h>
#import <ConnectedDevicesRemoteSystemsCommanding/MCDAppServiceRequest.h>
#import <ConnectedDevicesRemoteSystemsCommanding/MCDAppServiceResponse.h>
#import <ConnectedDevicesRemoteSystemsCommanding/MCDStatelessAppServiceResponse.h>
#import <ConnectedDevicesRemoteSystemsCommanding/MCDRemoteSystemConnectionRequest.h>

typedef NS_ENUM(NSInteger, MCDAppServiceClosedStatus)
{
    MCDAppServiceClosedStatusCompleted = 0,
    MCDAppServiceClosedStatusCanceled,
    MCDAppServiceClosedStatusResourceLimitsExceeded,
    MCDAppServiceClosedStatusUnknown
};

typedef NS_ENUM(NSInteger, MCDAppServiceConnectionStatus)
{
    MCDAppServiceConnectionStatusSuccess = 0,
    MCDAppServiceConnectionStatusAppNotInstalled,
    MCDAppServiceConnectionStatusAppUnavailable,
    MCDAppServiceConnectionStatusAppServiceUnavailable,
    MCDAppServiceConnectionStatusUnknown,
    MCDAppServiceConnectionStatusRemoteSystemUnavailable,
    MCDAppServiceConnectionStatusRemoteSystemNotSupportedByApp,
    MCDAppServiceConnectionStatusNotAuthorized
};

// clang-format off
__attribute__((visibility("default")))
@interface MCDAppServiceRequestReceivedEventArgs : NSObject
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@property(nonatomic, readonly, nonnull) MCDAppServiceRequest* request;
@end

__attribute__((visibility("default")))
@interface MCDAppServiceClosedEventArgs : NSObject
+ (nullable instancetype) new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@property(nonatomic, readonly) MCDAppServiceClosedStatus status;
@end

__attribute__((visibility("default")))
@interface MCDAppServiceConnection : NSObject
- (nullable instancetype)init;

- (nullable instancetype)initWithAppServiceInfo:(nonnull MCDAppServiceInfo*) appServiceInfo;
+ (nullable instancetype)appServiceConnectionWithAppServiceInfo:(nonnull MCDAppServiceInfo*) appServiceInfo;

- (void)openRemoteAsync:(nonnull MCDRemoteSystemConnectionRequest*)connectionRequest
             completion:(nonnull void (^)(MCDAppServiceConnectionStatus, NSError* _Nullable))completion;
- (void)close;

- (void)sendMessageAsync:(nonnull NSDictionary*)message
              completion:(nonnull void (^)(MCDAppServiceResponse* _Nonnull, NSError* _Nullable))completion;

@property(nonatomic, retain, nonnull) MCDAppServiceInfo* appServiceInfo;

@property(nonatomic, readonly, nonnull) MCDEvent<MCDAppServiceConnection*, MCDAppServiceRequestReceivedEventArgs*>* requestReceived;
@property(nonatomic, readonly, nonnull) MCDEvent<MCDAppServiceConnection*, MCDAppServiceClosedEventArgs*>* serviceClosed;

+ (void)sendStatelessMessageAsync:(nonnull NSDictionary*)message
                     toAppService:(nonnull MCDAppServiceInfo*)appServiceInfo
                connectionRequest:(nonnull MCDRemoteSystemConnectionRequest*)connectionRequest
                       completion:(nonnull void (^)(MCDStatelessAppServiceResponse* _Nonnull, NSError* _Nullable))completion;
@end
