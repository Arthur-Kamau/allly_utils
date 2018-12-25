/*
  * model snake case.
  * class Camel case

  //contents
    ->id (int auto increments.)
    ->user id (initiator of sending invite link)
    ->client mssidn (receiver of invite)
    ->Group id (nullable if invite is for a group)
    ->Status (Sending,Received)
*/ 
enum ReferalStatus{
  Received,
  Sending
}

class ReferalModule{
  int id;
  String userId;
  String clientMssidn;
  String groupId;
  ReferalStatus status;
    DateTime createdAt;
  DateTime updatedAt;
  
}