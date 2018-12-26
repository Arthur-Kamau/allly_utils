/*
  * model snake case.
  * class Camel case

  //contents
  ->id (autoincrement)
  ->user id  (unique for each user)
  -> user status (publically seen status)
  ->location ( object latitude,longitude, region)
  ->interstest (list of items)
  ->Profile Image.

*/ 

class UserLocation{
  String latitude;
  String longitude;
}

class UserParam{
  int id;
  int userId;
  String userStatus;
  UserLocation location;
  String userProfile;
   DateTime createdAt;
  DateTime updatedAt;

  UserParam(
    {
      this.id,
      this.userId,
      this.userStatus,
      this.location,
      this.userProfile,
      this.createdAt,
      this.updatedAt
    }
  );
}