/*
  * model snake case.
  * class Camel case

   //contents
   ->id
   ->user id
   ->status (blocked,active)
   ->mssidn (phone number)
   -> country
   -> created at,updated at

   //user status code
   //options - > active,blacklist,deleted
   1=active,
   2=
*/ 


class UserModel{
  int id;
  String userId;
  int status;
  String mssidn;
  String country;
  DateTime createdAt;
  DateTime updatedAt;

  UserModel(
    {
      this.id,
      this.userId,
      this.status,
      this.mssidn,
      this.country,
      this.createdAt,
      this.updatedAt,
    }
  );
}