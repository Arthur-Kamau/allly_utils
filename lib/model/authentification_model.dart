/*
  * model snake case.
  * class Camel case

  //contents
  -> userid unique for each user
  ->token (given when user logs in)
  ->Status (enum blocked,ok)
  ->created,updated
  ->public key (this is for the upcomming encryption module)

*/ 

enum AuthentificationStatus{
  active,
  blocked
}
class AuthentificationModule{
  int id;
  String userId;
  AuthentificationStatus status;
  String publicKey;
  DateTime createdAt;
  DateTime updatedAt;
}