#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ConnectedDevices/ConnectedDevices.h"
#import "ConnectedDevices/MCDConnectedDevicesAccessTokenInvalidatedEventArgs.h"
#import "ConnectedDevices/MCDConnectedDevicesAccessTokenRequest.h"
#import "ConnectedDevices/MCDConnectedDevicesAccessTokenRequestedEventArgs.h"
#import "ConnectedDevices/MCDConnectedDevicesAccount.h"
#import "ConnectedDevices/MCDConnectedDevicesAccountManager.h"
#import "ConnectedDevices/MCDConnectedDevicesAddAccountResult.h"
#import "ConnectedDevices/MCDConnectedDevicesNotificationRegistration.h"
#import "ConnectedDevices/MCDConnectedDevicesNotificationRegistrationManager.h"
#import "ConnectedDevices/MCDConnectedDevicesNotificationRegistrationState.h"
#import "ConnectedDevices/MCDConnectedDevicesNotificationRegistrationStateChangedEventArgs.h"
#import "ConnectedDevices/MCDConnectedDevicesPlatform.h"
#import "ConnectedDevices/MCDConnectedDevicesPlatformSettings.h"
#import "ConnectedDevices/MCDConnectedDevicesProcessNotificationOperation.h"
#import "ConnectedDevices/MCDConnectedDevicesRemoveAccountResult.h"
#import "ConnectedDevices/MCDEvent.h"

#import "ConnectedDevicesRemoteSystems/ConnectedDevicesRemoteSystems.h"
#import "ConnectedDevicesRemoteSystems/MCDAppServiceInfo.h"
#import "ConnectedDevicesRemoteSystems/MCDRemoteSystem.h"
#import "ConnectedDevicesRemoteSystems/MCDRemoteSystemAccountFilter.h"
#import "ConnectedDevicesRemoteSystems/MCDRemoteSystemAddedEventArgs.h"
#import "ConnectedDevicesRemoteSystems/MCDRemoteSystemApp.h"
#import "ConnectedDevicesRemoteSystems/MCDRemoteSystemAuthorizationKindFilter.h"
#import "ConnectedDevicesRemoteSystems/MCDRemoteSystemDiscoveryTypeFilter.h"
#import "ConnectedDevicesRemoteSystems/MCDRemoteSystemEnumerationCompletedEventArgs.h"
#import "ConnectedDevicesRemoteSystems/MCDRemoteSystemFilter.h"
#import "ConnectedDevicesRemoteSystems/MCDRemoteSystemKindFilter.h"
#import "ConnectedDevicesRemoteSystems/MCDRemoteSystemKinds.h"
#import "ConnectedDevicesRemoteSystems/MCDRemoteSystemLocalVisibilityKindFilter.h"
#import "ConnectedDevicesRemoteSystems/MCDRemoteSystemPlatformFilter.h"
#import "ConnectedDevicesRemoteSystems/MCDRemoteSystemRemovedEventArgs.h"
#import "ConnectedDevicesRemoteSystems/MCDRemoteSystemStatusTypeFilter.h"
#import "ConnectedDevicesRemoteSystems/MCDRemoteSystemUpdatedEventArgs.h"
#import "ConnectedDevicesRemoteSystems/MCDRemoteSystemWatcher.h"
#import "ConnectedDevicesRemoteSystems/MCDRemoteSystemWatcherErrorOccurredEventArgs.h"

#import "ConnectedDevicesRemoteSystemsCommanding/ConnectedDevicesRemoteSystemsCommanding.h"
#import "ConnectedDevicesRemoteSystemsCommanding/MCDAppServiceConnection.h"
#import "ConnectedDevicesRemoteSystemsCommanding/MCDAppServiceConnectionOpenedInfo.h"
#import "ConnectedDevicesRemoteSystemsCommanding/MCDAppServiceProvider.h"
#import "ConnectedDevicesRemoteSystemsCommanding/MCDAppServiceRequest.h"
#import "ConnectedDevicesRemoteSystemsCommanding/MCDAppServiceResponse.h"
#import "ConnectedDevicesRemoteSystemsCommanding/MCDLaunchUriProvider.h"
#import "ConnectedDevicesRemoteSystemsCommanding/MCDRemoteLauncher.h"
#import "ConnectedDevicesRemoteSystemsCommanding/MCDRemoteLauncherOptions.h"
#import "ConnectedDevicesRemoteSystemsCommanding/MCDRemoteSystemAppRegistration.h"
#import "ConnectedDevicesRemoteSystemsCommanding/MCDRemoteSystemConnectionInfo.h"
#import "ConnectedDevicesRemoteSystemsCommanding/MCDRemoteSystemConnectionRequest.h"
#import "ConnectedDevicesRemoteSystemsCommanding/MCDStatelessAppServiceResponse.h"

#import "ConnectedDevicesUserData/ConnectedDevicesUserData.h"
#import "ConnectedDevicesUserData/MCDUserDataFeedSyncScope.h"
#import "ConnectedDevicesUserData/MCDUserDataFeed.h"

#import "ConnectedDevicesUserDataUserActivities/ConnectedDevicesUserDataUserActivities.h"
#import "ConnectedDevicesUserDataUserActivities/MCDUserActivity.h"
#import "ConnectedDevicesUserDataUserActivities/MCDUserActivityAttribution.h"
#import "ConnectedDevicesUserDataUserActivities/MCDUserActivityChannel.h"
#import "ConnectedDevicesUserDataUserActivities/MCDUserActivitySession.h"
#import "ConnectedDevicesUserDataUserActivities/MCDUserActivitySessionHistoryItem.h"
#import "ConnectedDevicesUserDataUserActivities/MCDUserActivityVisualElements.h"

#import "ConnectedDevicesUserDataUserNotifications/ConnectedDevicesUserDataUserNotifications.h"
#import "ConnectedDevicesUserDataUserNotifications/MCDUserNotification.h"
#import "ConnectedDevicesUserDataUserNotifications/MCDUserNotificationChannel.h"
#import "ConnectedDevicesUserDataUserNotifications/MCDUserNotificationReader.h"
#import "ConnectedDevicesUserDataUserNotifications/MCDUserNotificationReaderOptions.h"
#import "ConnectedDevicesUserDataUserNotifications/MCDUserNotificationUpdateResult.h"

FOUNDATION_EXPORT double ConnectedDevicesVersionNumber;
FOUNDATION_EXPORT const unsigned char ConnectedDevicesVersionString[];

