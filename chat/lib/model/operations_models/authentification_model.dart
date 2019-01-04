/*
  * model snake case.
  * class Camel case

  //contents
  -> userid unique for each user
  ->token (given when user logs in)
  ->Status (enum blocked,ok)
  ->created,updated
  ->public key (this is for the upcomming encryption module)

 

  active =0 ,
  blocked =1
*/
class AuthentificationModule {
  int id;
  String userId;
  int status;
  String publicKey;
  DateTime createdAt;
  DateTime updatedAt;

  AuthentificationModule.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        publicKey = json['public_key'],
        createdAt = json['create_at'],
        updatedAt = json['update_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'public_key': publicKey,
        'email': createdAt,
        'update_at': updatedAt
      };
}
