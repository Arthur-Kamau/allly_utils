

class UserLocation{
  String latitude;
  String longitude;
}

class UserLoginModel{
  String userAgent;
  String token;
  String mssidn;
  UserLocation location;

  UserLoginModel(
    {
      this.userAgent,
      this.token,
      this.location
    }
  );
}