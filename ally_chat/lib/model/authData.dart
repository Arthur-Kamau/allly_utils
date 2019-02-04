import 'package:meta/meta.dart';

class AuthDetails {
  final String name;
  final String phoneNumber;
  final String countryCode;
  final String authtoken;
  final DateTime authTime;
  final String deviceId;

  AuthDetails(
      {
        @required this.name,
      @required this.phoneNumber,
       @required this.countryCode,
      @required this.authtoken,
      @required this.authTime,
      @required this.deviceId});
}
