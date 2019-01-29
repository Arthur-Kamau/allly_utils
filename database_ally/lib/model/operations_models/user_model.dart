/*
  * model snake case.
  * class Camel case


** Gender 
*  1-> male
*  2-> Female
*  3 -> other

   //contents
   ->id
   ->user id
   ->status (blocked,active)
   ->mssidn (phone number)
   -> location
   -> created at,updated at

   //user status code
   //options - > active,blacklist,deleted
   1=active,
   2=
*/

class UserModel {
  int id;
  String userId;
  int status;
  String mssidn;
  String location;
  String whatIDo;
  int gender;
  String interest;
  DateTime createdAt;
  DateTime updatedAt;

  UserModel({
    this.id,
    this.userId,
    this.status,
    this.mssidn,
    this.location,
    this.whatIDo,
    this.gender,
    this.interest,
    this.createdAt,
    this.updatedAt,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        status = json['status'],
        mssidn = json['mssidn'],
        whatIDo = json['what_i_do'],
        location = json['location'],
        gender = json['gender'],
        interest = json['interest'],
        createdAt = json['create_at'],
        updatedAt = json['update_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'status': status,
        'mssidn': mssidn,
        'what_i_do': whatIDo,
        'location': location,
        'gender': gender,
        'interest': interest,
        'create_at': createdAt,
        'update_at': updatedAt
      };
}
