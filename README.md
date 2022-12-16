# Titanium Freshchat SDK

Use the native Freshchat SDK (iOS / Android) in Titanium. All APIs are 100 % cross-platform! 🤘

## Setup

### iOS

No setup required

### Android

Add the following contents to your [app]/platform/android/build.gradle
```gradle
allprojects {
  repositories {
    jcenter()
    maven { url "https://jitpack.io" }
  }
}
```

## Example

See the [app.js](./example/app.js) for a full-featured example!

## APIs

### `initialize({ appId, appKey, domain })`

Initializes the SDK. The `domain` is optional.

### `identifyUser(externalId)`

Identifies a user with Freshchat for usage with an external user ID (e.g. of your own database)

### `signInUser({ firstName, lastName, email })`

Signs in a user with Freshchat. All values are optional!

### `updateUserProperty(key, value)`

Updates a given user property (`key`) by it's `value`.

### `signOutUser()`

Resets a user in Freshchat

### `getRestoreID()`

Receives the restore ID of the user (may be null if not defined)

### `trackEvent(eventName, parameters)`

Tracks an event by a given `eventName`. The `parameters` are optional.

### `showConversations()`

Opens the conversation list.

### `registerForPushNotifications(fcmToken)` (Android only)

Registers the given `fcmToken` with Freshchat. On iOS, this is handled internally by
the corresponding `didRegisterForRemoteNotificationsWithDeviceToken:` selector of the
`UIApplicationDelegate`.

## Events

### `userRestoreIdReceived`

Called when the restore ID has been received by the module. It includes the
keys `restoreID` and `externalID` which can both be optional.

## Author

Hans Knöchel

## License

MIT
