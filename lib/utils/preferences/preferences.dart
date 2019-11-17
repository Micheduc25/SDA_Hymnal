import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class MyAppSettings {
  MyAppSettings(StreamingSharedPreferences preferences)
      : email = preferences.getString('email', defaultValue: ''),
        password = preferences.getString('password', defaultValue: ''),
        hasAccount = preferences.getBool('hasAccount', defaultValue: false),
        hasLoggedOut = preferences.getBool('hasLoggedOut', defaultValue: false);

  final Preference<String> email;
  final Preference<String> password;
  final Preference<bool> hasAccount;
  final Preference<bool> hasLoggedOut;
}
