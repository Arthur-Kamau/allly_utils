

class UserLocation{
  String latitude;
  String longitude;
}

class UserLoginModel{
 
String countryCode;
String userAgent;//mobile web etc
String appToken; //constant in each app
String osId ; //each os has a unique id
  UserLocation location;

  UserLoginModel(
    {
      this.userAgent,
      this.countryCode,
      this.appToken,
      this.osId,
      this.location
    }
  );
}