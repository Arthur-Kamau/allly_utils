class Register {
  String name;
  String phoneNumber;
  String countryCode;
  String userAgent; //mobile web etc
  String appToken; //constant in each app
  String osId; //each os has a unique id
  String location;

  Register(
    this.name,
    this.phoneNumber,
    this.countryCode,
    this.userAgent,
    this.appToken,
    this.osId,
    this.location,
  );

  Register.fromJson(Map<String, dynamic> json)
      : countryCode = json['country_code'],
        phoneNumber = json['phone_number'],
        userAgent = json['user_agent'],
        appToken = json['app_token'],
        location = json['location'],
        osId = json['os_id'];

  Map<String, dynamic> toJson() => {
        'country_code': countryCode,
        'phone_number': phoneNumber,
        'user_agent': userAgent,
        'app_token': appToken,
        'os_id': osId,
        'location': location
      };
}
