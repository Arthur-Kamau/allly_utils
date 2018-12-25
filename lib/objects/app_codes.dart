/*
  *this files contains class which represent the codes
  *for status and permission.
  *this enables the codes to be altered only in one file.
  *incase of future updtes,if change in status/permission codes 
  *only this file is to be changed.
*/

//for groups
class GroupPermisionCode{

  
     static const int  UserAssignPermissions=  0;
     static const int  UserInviteUser=  1;
     static const int  UserRemoveUser=  2;
     static const int  UserDeleteChatItem=  3;
     static const int  UserWriteChat=  4;
     static const int  UserReadChat=  5;
    

}

//for referal code
class ReferalStatusCode{
     static const int  InviteRecieved=  0;
     static const int  InvitePending=  1;
     static const int  InviteIgnored=  2;
}

//for media chat
//p2p
class MediaChatCode{
  static const int  MediaPending=  0;
  static const int  MediaReceived=  1;
  static const int  MediaViewed=  2;
  static const int  MediaDeleted=  3;
}

//viewing status
class StatusCode{
   static const int ViewAll = 0;
    static const int ViewContacts=1;
    static const int ViewSelect = 2;
    static const int ViewAllExcept =3;
}