# OneSignal Setup Guide for Temy Barber App

## Overview
This guide will help you complete the OneSignal configuration for push notifications in the Temy Barber booking app.

## Current Status
✅ **Completed:**
- OneSignal Flutter package integration
- Android permissions and configuration
- Complete NotificationService implementation
- Deep linking navigation system
- UI screens for notification settings and history
- Backend API integration for notifications
- State management with NotificationCubit
- Dependency injection setup

❌ **Pending:**
- OneSignal App ID configuration
- Testing and validation

## Quick Setup (5 minutes)

### Step 1: Get Your OneSignal App ID

1. **Create OneSignal Account:**
   - Go to [https://onesignal.com/](https://onesignal.com/)
   - Sign up or sign in

2. **Create New App:**
   - Click "New App/Website"
   - Enter app name: "Temy Barber Booking"
   - Select "Mobile App"
   - Choose platforms: Android (and iOS if needed)

3. **Get App ID:**
   - Complete the setup wizard
   - Copy your App ID (format: `12345678-1234-1234-1234-123456789012`)

### Step 2: Configure App ID

Update the App ID in **2 files**:

#### File 1: `lib/core/config/notification_config.dart`
```dart
// Replace this line:
static const String oneSignalAppId = "YOUR_ONESIGNAL_APP_ID";

// With your actual App ID:
static const String oneSignalAppId = "12345678-1234-1234-1234-123456789012";
```

#### File 2: `android/app/build.gradle`
```gradle
// Replace this line:
onesignalAppId: "YOUR_ONESIGNAL_APP_ID"

// With your actual App ID:
onesignalAppId: "12345678-1234-1234-1234-123456789012"
```

### Step 3: Test Configuration

1. **Run the app:**
   ```bash
   flutter run
   ```

2. **Check logs for:**
   - `✅ OneSignal initialized successfully`
   - `📱 Notification permission: ✅ Granted`

3. **Test notifications:**
   - Uncomment the test line in `main_development.dart`:
     ```dart
     await NotificationHelper.testNotifications();
     ```

## Android Configuration (Advanced)

### Firebase Integration (if needed)

If you need Firebase Cloud Messaging:

1. **Get Firebase Server Key:**
   - Go to Firebase Console → Project Settings → Cloud Messaging
   - Copy "Server key"

2. **Configure in OneSignal:**
   - In OneSignal dashboard → Settings → Platforms → Android
   - Enter Firebase Server Key and Sender ID

### Permissions Already Added

The following permissions are already configured in `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.WAKE_LOCK" />
<uses-permission android:name="android.permission.VIBRATE" />
<uses-permission android:name="com.google.android.c2dm.permission.RECEIVE" />
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```

## Features Available

### 1. **Notification Service** (`NotificationService`)
- OneSignal initialization
- Permission handling
- Deep linking navigation
- User ID management
- Device token handling

### 2. **UI Components**
- **Profile Screen:** Notification toggle and settings access
- **Settings Screen:** Categorized notification preferences
- **History Screen:** View past notifications with read/unread states

### 3. **Backend Integration**
- Device token API endpoints
- Notification settings management
- Notification history retrieval
- Mark notifications as read

### 4. **Deep Linking**
Automatically handles navigation for:
- `booking_details` → Booking details screen
- `upcoming_bookings` → Bookings list
- `promotion` → Promotions screen
- Default → Home screen

## Testing Checklist

- [ ] App ID configured in both files
- [ ] App runs without errors
- [ ] OneSignal initialization logs show success
- [ ] Notification permission requested and granted
- [ ] Test notification sent and received
- [ ] Deep linking navigation works
- [ ] Settings screen loads and saves preferences
- [ ] History screen displays notifications

## Troubleshooting

### Common Issues:

1. **"OneSignal App ID not configured"**
   - Update `NotificationConfig.oneSignalAppId`

2. **"Failed to initialize OneSignal"**
   - Check internet connection
   - Verify App ID format
   - Check OneSignal dashboard

3. **Notifications not received**
   - Check device notification permissions
   - Verify OneSignal dashboard shows your device
   - Check device token registration

4. **Deep linking not working**
   - Verify notification payload includes correct `type` field
   - Check navigation routes are properly configured

### Debug Commands:

```dart
// Add to main_development.dart for testing:
import 'package:temy_barber/core/utils/notification_helper.dart';

// In main():
NotificationHelper.printSetupInstructions();
await NotificationHelper.testNotifications();
```

## Next Steps

After completing the setup:

1. **Test on physical device** (notifications don't work in simulators)
2. **Send test notifications** from OneSignal dashboard
3. **Configure notification templates** in OneSignal
4. **Set up segments** for targeted notifications
5. **Integrate with backend** to send automatic booking notifications

## Support

- OneSignal Documentation: [https://documentation.onesignal.com/](https://documentation.onesignal.com/)
- Flutter OneSignal Package: [https://pub.dev/packages/onesignal_flutter](https://pub.dev/packages/onesignal_flutter)

---

**That's it! 🎉**

Your notification system is ready to use once you update the App ID. The entire infrastructure is already in place - you just need those two configuration updates to make it live.
