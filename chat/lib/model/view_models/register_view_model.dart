class Register{
  String name;
String phoneNumber;
String countryCode;
String userAgent;//mobile web etc
String appToken; //constant in each app
String osId ; //each os has a unique id
DateTime createTime;
DateTime upDateTime;

Register(
this.name,
this.phoneNumber,
this.countryCode,
this.userAgent,
this.appToken,
this.osId,
this.createTime,
this.upDateTime
);

}