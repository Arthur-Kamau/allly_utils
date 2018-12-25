/*
  * model snake case.
  * class Camel case

  //contents
   ->id (int auto increment)
   ->user id (unique for each user)
   ->Permission id (
         => enum{
           Delete,write,read,invite,removalAssign Permission,Send,Comment,Permission id.
         }
   )
*/ 

enum GroupPermission{
  Delete,Write,Read,Invite,Remove,AssignPermission,SendInvite,Comment,PermissionId

}
class GroupModule{
  int id;
  String userId;
  String groupId;
  List<GroupPermission> permissions;
  DateTime createdAt;
  DateTime updatedAt;
}