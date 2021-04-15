# Contoso Airlines iOS App

## IMPORTANT

**This sample has been archived and is no longer being maintained. For a more current sample using Microsoft Graph from Swift, please see https://github.com/microsoftgraph/msgraph-training-ios-swift.**

## Prerequisites

Minimally, you'll need XCode to compile and run this sample, along with a physical iOS device to debug the application. In order to enable the Graph notifications portion of the demo, you'll also need to setup the [Contoso Airlines Flight Team Provisioning Sample](https://github.com/microsoftgraph/contoso-airlines-azure-functions-sample), including the optional configuration to enable Graph notifications.

## Setup

### Add Project Rome service principals to your tenant

You need the [Azure Active Directory Powershell module](https://docs.microsoft.com/powershell/azure/active-directory/overview?view=azureadps-2.0) to perform this step.

1. Open Powershell and enter `Connect-AzureAD -TenantDomain YOUR_DOMAIN` to authenticate to Azure AD as an administrator.
1. Run the following commands to add three service principals:

    ```PowerShell
    New-AzureADServicePrincipal -AppId d32c68ad-72d2-4acb-a0c7-46bb2cf93873
    New-AzureADServicePrincipal -AppId 04436913-cf0d-4d2a-9cc6-2ffe7f1d3d1c
    New-AzureADServicePrincipal -AppId 19686ca6-5324-4571-a231-77e026b0e06f
    ```

### Register an application in the Azure portal

Register an app in the Azure portal named **Flight Team iOS App**.

- Accounts in this organizational directory only
- Redirect URI: (leave blank on create screen, set on the **Authentication** tab). Choose the following two options under **Suggested Redirect URIs for public clients (mobile, desktop):
  - The value that starts with `msal`
  - `urn:ietf:wg:oauth:2.0:oob`
- Add delegated permissions for Graph:
  - **Calendars.Read**
  - **User.Read**
  - **User.Read.All**
- Add delegated permissions for Microsoft Activity Feed Service:
  - **Notifications.ReadWrite.CreatedByApp**
  - **UserActivity.ReadWrite.CreatedByApp**
- Add delegated permissions for Microsoft Command Service:
  - **Device.Command**
  - **Device.Read**
- Add delegated permissions for Microsoft Device Directory Service:
  - **dds.read**
  - **dds.register**
- Add delegated permissions for Windows Notification Service:
  - **wns.connect**
- Add delegated permissions for **Flight Team Notification Service**
  - **Notifications.Send**
- After adding the permissions, use the **Grant admin consent for Contoso** button
- Rename the **./FlightSchedule/Config/AppConfig.swift.example** file to **AppConfig.swift** and set the values for `appId`, `tenantId`, and `notificationDomain`.
- Edit the **./FlightSchedule/Info.plist** file and replace the `YOUR_APP_ID_HERE` value with your app ID.
- Add the application ID in the **Support Microsoft Account & Azure Active Directory** section of your cross-device experience registration in the Windows Dev Center.

### Triggering a notification

Assuming you have the [Contoso Airlines Flight Team Provisioning Sample](https://github.com/microsoftgraph/contoso-airlines-azure-functions-sample) deployed and working, you can trigger a notification to this app if you are signed in as a user that is a member of an existing flight team. Using your flight administrator account, modify the flight in the SharePoint list to update either the departure gate or departure time.
