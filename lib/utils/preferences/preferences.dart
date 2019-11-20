import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class MyAppSettings {
  MyAppSettings(StreamingSharedPreferences preferences)
      : email = preferences.getString('email', defaultValue: ''),
        password = preferences.getString('password', defaultValue: ''),
        hasAccount = preferences.getBool('hasAccount', defaultValue: false),
        hasLoggedOut = preferences.getBool('hasLoggedOut', defaultValue: false),
        isEmailVerified =
            preferences.getBool("emailVerified", defaultValue: false),
        userName = preferences.getString("userName", defaultValue: ""),
        updateMode = preferences.getString("updateMode", defaultValue: "");

  final Preference<String> email;
  final Preference<String> password;
  final Preference<bool> hasAccount;
  final Preference<bool> hasLoggedOut;
  final Preference<bool> isEmailVerified;
  final Preference<String> userName;
  final Preference<String> updateMode;
}
