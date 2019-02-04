import 'package:shared_preferences/shared_preferences.dart';

class UserPhoneNumberAndCountryCodePreferenceAsset {
  Future<void> setCountryCode(String countryCode) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setString("countryCode", countryCode);
  }
  Future<String> getCountryCode() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    final String countryCode = (prefs.getString('countryCode') ?? "");
    return countryCode.isEmpty || countryCode == null ? "" : countryCode;
  }

  Future<void> setPhoneNumber(String phoneNumber) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setString("phoneNumber", phoneNumber);
  }
  Future<String> getPhoneNumber() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    final String phoneNumber = (prefs.getString('phoneNumber') ?? "");
    return phoneNumber.isEmpty || phoneNumber == null ? "" : phoneNumber;
  }
}