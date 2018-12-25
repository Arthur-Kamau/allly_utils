/*
  * model snake case.
  * class Camel case

  //contents
  -> id mandatory field (primary key)
  -> user id -> sender (person/bot sending status)
  -> policy (
            status view policy
              *view all
              *view contacts
              *view select
              *view all except
            )
  ->contacts allowed (array) 
      *nullable by default
      * depends on policy if view all except
  ->media type (enum text/image/video/thumbanials)
  -> media path  (if image/video)
  -> media contents (if string ->text)
  ->created at 
  ->updated at
  ->viewed (array of user id)
*/
import 'package:ally_utils/objects/app_codes.dart';

class UserStatus {
  int id;
  String userId; //sender
  StatusCode statusPolicy;
  List<String> contactBlocked;
  List<String> contactAllowed;
  String mediaContents;
  String mediaPath;
  List<String> userViewed;
  bool isdeleted;
  DateTime createdAt;
  DateTime updatedAt;
}
