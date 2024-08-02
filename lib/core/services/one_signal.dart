import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OneSignalService {
  static final OneSignalService _instance = OneSignalService._internal();

  factory OneSignalService() {
    return _instance;
  }

  OneSignalService._internal();

  Future<void> initialize(String oneSignalAppId) async {
    OneSignal.shared.setAppId(oneSignalAppId);
    
    await OneSignal.shared.promptUserForPushNotificationPermission();
     
     final response = await Supabase.instance.client
      .from('users')
      .select()
      .then((data) {

      });

  if (response.error == null) {
    final List users = response.data;
    for (var user in users) {
      String userId = user['id'];
      String userType = user['user_type'];

      // Update OneSignal tags
      OneSignal.shared.sendTag('user_id', userId);
      OneSignal.shared.sendTag('user_type', userType);
    }
  } else {
    print('Error fetching users: ${response.error.message}');
  }


  // Configure OneSignal settings
  OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
    // Handle notification received while the app is in the foreground
    print("Notification received in foreground: ${event.notification.jsonRepresentation()}");
    event.complete(event.notification);
  });

  OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    // Handle notification opened
    print("Notification opened: ${result.notification.jsonRepresentation()}");
  });

  OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
    // Handle permission state changes
    print("Permission state changed: ${changes.to.status}");
  });

  OneSignal.shared.setSubscriptionObserver((OSSubscriptionStateChanges changes) {
    // Handle subscription state changes
    print("Subscription state changed: ${changes.to.userId}");
  });

  OneSignal.shared.setEmailSubscriptionObserver((OSEmailSubscriptionStateChanges emailChanges) {
    // Handle email subscription state changes
    print("Email subscription state changed: ${emailChanges.to.emailAddress}");
  });

  // Other optional settings and configurations
  OneSignal.shared.setRequiresUserPrivacyConsent(false); // Set according to your privacy policy

  // Complete initialization
  }
}
