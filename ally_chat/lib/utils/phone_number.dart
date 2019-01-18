import 'package:ally_chat/utils/random.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PhoneNumber {
  //get phone number
  Future<String> getPhoneNumber() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    return (prefs.getString('phone_number') ?? "");
  }

  //set phone number
  Future<void> setPhoneNumber(String phone_number) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setString("phone_number", phone_number);
  }

//filter phone number
  String filterPhoneNumber(String phoneNumber, String countryCode) {
    String truePhoneNumber;
    //check if first number is 0
    if (phoneNumber[0] == '0') {
      truePhoneNumber = phoneNumber.substring(1);
    }
    //prepend country code
    //return the phone number

    return countryCode + truePhoneNumber;
  }
}

