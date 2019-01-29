/**
 * int content type
 * 1->image.
 * 2->video
 * 3->audio
 * 
 * status policy
 * 1 -> everybody can view
 * 2 -> my Contact;
 * 3 -> only select
 * 
 * status category
 * 1 -> my status
 * 2 -> my Contact status (private)
 * 3 -> public status
 * 4 ->trending status
 */

class StatusModel {
  int contentType;
  String contentLink;
  bool isDeleted;
  List<String> usersViewed;
  List<String> usersLiked;
  DateTime creationTime;

}

class UserStatusModel {
  String userId;     //unique for each user
  String userName;   //username saved
  String userAvatar; // link to user avatare

  int viewPolicy;
  List<StatusModel> userStatus;
  List<String> userblocked;
  List<String> userAllowedToView;

  DateTime creationTime;
  DateTime updateTime;

}