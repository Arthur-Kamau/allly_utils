import 'package:register/utils/random.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AppId {
//creates app id if not exist then cloise
//if app id exist it closes
  Future<void> stateAppId() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    final String appId = (prefs.getString('app_id') ?? "");
    if (appId.isEmpty || appId == null) {
      String genAppId = AppRandom().randomString(10);
      prefs.setString("app_id", genAppId);
    }
  }

//get if device id exist
//if not exist create and return one
  Future<String> getAppId() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    final String appId = (prefs.getString('app_id') ?? "");
    if (appId.isEmpty || appId == null) {
      String genAppId = AppRandom().randomString(10);
      prefs.setString("app_id", genAppId);
      return genAppId;
    } else {
      return appId;
    }
  }
}
