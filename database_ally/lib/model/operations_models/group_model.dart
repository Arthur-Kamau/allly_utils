/*
 
  //group type
  0 =>private groups,
  1=>public groups,

  //user permission
  0=> read //default
  1=> send message
  2 => add users to group /remove users
  3 => delete item in group chat history

  4 => send  invitation 
  
*/ 

class UserGroupModel{
  int id;
  String userId;
  bool isGroupMuted;
  int userPermision;
   DateTime createdAt;
  DateTime updatedAt;

   UserGroupModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        isGroupMuted = json['is_group_muted'],
        userPermision = json['user_permission'],
    
        createdAt = json['create_at'],
        updatedAt = json['update_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'is_group_muted': isGroupMuted,
        'user_permission': userPermision,
  
        'create_at': createdAt,
        'update_at': updatedAt
      };
}
class GroupModel{
  int id;
  String groupId;
  int groupType;
  String groupMembers; //list comma separetd
  DateTime createdAt;
  DateTime updatedAt;

     GroupModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        groupId = json['group_id'],
        groupType = json['group_type'],
        groupMembers = json['group_members'],
    
        createdAt = json['create_at'],
        updatedAt = json['update_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'group_id': groupId,
        'group_type': groupType,
        'group_members': groupMembers,
  
        'create_at': createdAt,
        'update_at': updatedAt
      };

}