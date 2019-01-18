import 'dart:collection';

import 'package:geolocator/geolocator.dart';

class LatLong {
//location access status
  Future<GeolocationStatus> getLocationStatus() async {
    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();
    return geolocationStatus;
  }

  Future<String> getLat() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position.latitude.toString();
  }

  Future<String> getLong() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position.longitude.toString();
  }

  Future<Map<String, String>> getLatLong() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var map = <String, String>{
      'lat': position.latitude.toString(),
      'long': position.longitude.toString()
    };
    return map;
  }

  /***
   * last known if location is turned off
   * by user or deny permission
   * 
   */

  Future<String> getLastKnownLat() async {
    Position position = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    return position.latitude.toString();
  }

  Future<String> getLastKnownLong() async {
    Position position = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    return position.longitude.toString();
  }

  Future<Map<String, String>> getLastKnownLatLong() async {
    Position position = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    var map = <String, String>{
      'lat': position.latitude.toString(),
      'long': position.longitude.toString()
    };
    return map;
  }
}
