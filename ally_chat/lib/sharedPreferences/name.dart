import 'package:shared_preferences/shared_preferences.dart';

class ContactNamePreferenceAsset {
  Future<void> setUserName(String userName) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setString("userName", userName);
  }
  Future<String> getUserName() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    final String userName = (prefs.getString('userName') ?? "");
    return userName.isEmpty || userName == null ? "" : userName;
  }

}