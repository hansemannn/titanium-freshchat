# Titanium Freshchat SDK

Use the native Freshchat SDK (iOS / Android) in Titanium

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

### `trackEvent(eventName, parameters)`

Tracks an event by a given `eventName`. The `parameters` are optional.

### `showConversations()`

Opens the conversation list.

### `registerForPushNotifications(fcmToken)` (Android only)

Registers the given `fcmToken` with Freshchat. On iOS, this is handled internally by
the corresponding `didRegisterForRemoteNotificationsWithDeviceToken:` selector of the
`UIApplicationDelegate`.

## Author

Hans Knöchel

## License

MIT
