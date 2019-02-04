

class LoginResponse{
   bool okay;
  String reason;

  LoginResponse(
    this.okay,
    this.reason,
  );
   LoginResponse.fromJson(Map<String, dynamic> json)
      : okay = json['okay'],
        reason = json['reason'];
Map<String, dynamic> toJson() => {
        'okay': okay,
        'reason': reason
};
}

class UserLoginModel {
  String countryCode;
  String phoneNumber;
  String userAgent; //mobile web etc
  String appToken; //constant in each app
  String osId; //each os has a unique id
  String location;

  UserLoginModel(
      {this.userAgent,
      this.countryCode,
      this.phoneNumber,
      this.appToken,
      this.osId,
      this.location});

  UserLoginModel.fromJson(Map<String, dynamic> json)
      : countryCode = json['country_code'],
      phoneNumber = json['phone_number'],
        userAgent = json['user_agent'],
        appToken = json['app_token'],
        location = json['location'],
        osId = json['os_id'];

  Map<String, dynamic> toJson() => {
        'country_code': countryCode,
        'phone_number':phoneNumber,
        'user_agent': userAgent,
        'app_token': appToken,
        'os_id': osId,
        'location': location
      };
}
