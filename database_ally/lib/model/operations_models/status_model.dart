/**
 * int content type
 * 1->image.
 * 2->video
 * 3->audio
 * 
 * 1 -> everybody can view
 * 2 -> my Contact;
 * 3 -> only select
 * 
 */

class StatusModel {
  int contentType;
  String contentLink;
  bool isDeleted;
  List<String> usersViewed;
  List<String> usersLiked;
  DateTime creationTime;

  StatusModel({
    this.contentType,
    this.contentLink,
    this.isDeleted,
    this.usersViewed,
    this.usersLiked,
    this.creationTime,
  });

  StatusModel.fromJson(Map<String, dynamic> json)
      : contentType = json['content_type'],
        contentLink = json['content'],
        isDeleted = json['is_deleted'],
        usersViewed = json['user_viewed'],
        usersLiked = json['users_liked'],
        creationTime = json['creation_time'];

  Map<String, dynamic> toJson() => {
        'content_type': contentType,
        'content': contentLink,
        'is_deleted': isDeleted,
        'user_viewed': usersViewed,
        'users_liked': usersLiked,
        'creation_time': creationTime
      };
}

class UserStatusModel {
  String userId;
  String userName;
  String userAvatar;
  int viewPolicy;
  List<StatusModel> userStatus;
  List<String> userblocked;
  List<String> userAllowedToView;

  DateTime creationTime;
  DateTime updateTime;

  UserStatusModel(
      {this.userId,
      this.userName,
      this.userAvatar,
      this.userStatus,
      this.viewPolicy,
      this.userblocked,
      this.userAllowedToView,
      this.creationTime,
      this.updateTime});

  UserStatusModel.fromJson(Map<String, dynamic> json)
      : userId = json['user_id'],
        userName = json['user_name'],
        userAvatar = json['user_avatar'],
        userStatus = json['user_status'],
        viewPolicy = json['view_policy'],
        userblocked = json['users_blocked'],
        userAllowedToView = json['allowed_to_view'],
        creationTime = json['creation_time'],
        updateTime = json['update_time'];

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'user_name': userName,
        'user_avatar': userAvatar,
        'user_status': userStatus,
        'view_policy': viewPolicy,
        'users_blocked': userblocked,
        'allowed_to_view': userAllowedToView,
        'creation_time': creationTime,
        'update_time': updateTime
      };
}

List<UserStatusModel> myStatuslist = [
  new UserStatusModel(
      userId: "law",
      userName: "Lawrence yule",
      userAvatar: "assets/images/0.png",
      viewPolicy: 1,
      userStatus: [
        StatusModel(
          contentLink: "assets/media/3.mp4",
          contentType: 2,
          isDeleted: false,
          usersViewed: ["apande", "anon", "artwan", "kamau", "kenn"],
          usersLiked: ["apande", "anon", "artwan"],
          creationTime: DateTime.now().subtract(Duration(hours: 23)),
        ),
        StatusModel(
          contentLink: "assets/images/1.png",
          contentType: 1,
          isDeleted: false,
          usersViewed: ["apande", "anon", "artwan", "kamau", "kenn"],
          usersLiked: ["apande", "anon", "artwan"],
          creationTime: DateTime.now().subtract(Duration(hours: 23)),
        ),
        StatusModel(
          contentLink: "assets/media/2.mp3",
          contentType: 2,
          isDeleted: false,
          usersViewed: ["apande", "anon", "artwan", "kamau", "kenn"],
          usersLiked: ["apande", "anon", "artwan"],
          creationTime: DateTime.now().subtract(Duration(hours: 23)),
        ),
      ],
      userAllowedToView: [],
      userblocked: [],
      creationTime: DateTime.now().subtract(Duration(hours: 23)),
      updateTime: DateTime.now().subtract(Duration(hours: 23))),
];

List<UserStatusModel> Contacttatuslist = [
  new UserStatusModel(
      userId: "law",
      userName: "Lawrence yule",
      userAvatar: "assets/images/0.png",
      viewPolicy: 1,
      userStatus: [
        StatusModel(
          contentLink: "assets/media/3.mp4",
          contentType: 2,
          isDeleted: false,
          usersViewed: ["apande", "anon", "artwan", "kamau", "kenn"],
          usersLiked: ["apande", "anon", "artwan"],
          creationTime: DateTime.now().subtract(Duration(hours: 23)),
        ),
        StatusModel(
          contentLink: "assets/images/1.png",
          contentType: 1,
          isDeleted: false,
          usersViewed: ["apande", "anon", "artwan", "kamau", "kenn"],
          usersLiked: ["apande", "anon", "artwan"],
          creationTime: DateTime.now().subtract(Duration(hours: 23)),
        ),
        StatusModel(
          contentLink: "assets/media/2.mp3",
          contentType: 2,
          isDeleted: false,
          usersViewed: ["apande", "anon", "artwan", "kamau", "kenn"],
          usersLiked: ["apande", "anon", "artwan"],
          creationTime: DateTime.now().subtract(Duration(hours: 23)),
        ),
      ],
      userAllowedToView: [],
      userblocked: [],
      creationTime: DateTime.now().subtract(Duration(hours: 23)),
      updateTime: DateTime.now().subtract(Duration(hours: 23))),
];

List<UserStatusModel> publicStatuslist = [
  new UserStatusModel(
      userId: "law",
      userName: "Lawrence yule",
      userAvatar: "assets/images/0.png",
      viewPolicy: 1,
      userStatus: [
        StatusModel(
          contentLink: "assets/media/3.mp4",
          contentType: 2,
          isDeleted: false,
          usersViewed: ["apande", "anon", "artwan", "kamau", "kenn"],
          usersLiked: ["apande", "anon", "artwan"],
          creationTime: DateTime.now().subtract(Duration(hours: 23)),
        ),
        StatusModel(
          contentLink: "assets/images/1.png",
          contentType: 1,
          isDeleted: false,
          usersViewed: ["apande", "anon", "artwan", "kamau", "kenn"],
          usersLiked: ["apande", "anon", "artwan"],
          creationTime: DateTime.now().subtract(Duration(hours: 23)),
        ),
        StatusModel(
          contentLink: "assets/media/2.mp3",
          contentType: 2,
          isDeleted: false,
          usersViewed: ["apande", "anon", "artwan", "kamau", "kenn"],
          usersLiked: ["apande", "anon", "artwan"],
          creationTime: DateTime.now().subtract(Duration(hours: 23)),
        ),
      ],
      userAllowedToView: [],
      userblocked: [],
      creationTime: DateTime.now().subtract(Duration(hours: 23)),
      updateTime: DateTime.now().subtract(Duration(hours: 23))),
  new UserStatusModel(
      userId: "kamau",
      userName: "kenn kamau",
      userAvatar: "assets/images/1.png",
      viewPolicy: 1,
      userStatus: [
        StatusModel(
          contentLink: "assets/images/birds.jpg",
          contentType: 1,
          isDeleted: false,
          usersViewed: ["apande", "anon", "artwan", "kamau", "kenn"],
          usersLiked: ["apande", "anon", "artwan"],
          creationTime: DateTime.now().subtract(Duration(hours: 23)),
        ),
        StatusModel(
          contentLink: "assets/media/1.mp4",
          contentType: 2,
          isDeleted: false,
          usersViewed: ["apande", "anon", "artwan", "kamau", "kenn"],
          usersLiked: ["apande", "anon", "artwan"],
          creationTime: DateTime.now().subtract(Duration(hours: 23)),
        ),
        StatusModel(
          contentLink: "assets/media/3.mp4",
          contentType: 2,
          isDeleted: false,
          usersViewed: ["apande", "anon", "artwan", "kamau", "kenn"],
          usersLiked: ["apande", "anon", "artwan"],
          creationTime: DateTime.now().subtract(Duration(hours: 23)),
        ),
      ],
      userAllowedToView: [],
      userblocked: [],
      creationTime: DateTime.now().subtract(Duration(hours: 5)),
      updateTime: DateTime.now().subtract(Duration(hours: 5))),
];

List<UserStatusModel> trendingStatuslist = [
  new UserStatusModel(
      userId: "law",
      userName: "Lawrence yule",
      userAvatar: "assets/images/0.png",
      viewPolicy: 1,
      userStatus: [
        StatusModel(
          contentLink: "assets/media/3.mp4",
          contentType: 2,
          isDeleted: false,
          usersViewed: ["apande", "anon", "artwan", "kamau", "kenn"],
          usersLiked: ["apande", "anon", "artwan"],
          creationTime: DateTime.now().subtract(Duration(hours: 23)),
        ),
        StatusModel(
          contentLink: "assets/images/1.png",
          contentType: 1,
          isDeleted: false,
          usersViewed: ["apande", "anon", "artwan", "kamau", "kenn"],
          usersLiked: ["apande", "anon", "artwan"],
          creationTime: DateTime.now().subtract(Duration(hours: 23)),
        ),
        StatusModel(
          contentLink: "assets/media/2.mp3",
          contentType: 2,
          isDeleted: false,
          usersViewed: ["apande", "anon", "artwan", "kamau", "kenn"],
          usersLiked: ["apande", "anon", "artwan"],
          creationTime: DateTime.now().subtract(Duration(hours: 23)),
        ),
      ],
      userAllowedToView: [],
      userblocked: [],
      creationTime: DateTime.now().subtract(Duration(hours: 23)),
      updateTime: DateTime.now().subtract(Duration(hours: 23))),
  new UserStatusModel(
      userId: "kamau",
      userName: "kenn kamau",
      userAvatar: "assets/images/1.png",
      viewPolicy: 1,
      userStatus: [
        StatusModel(
          contentLink: "assets/images/birds.jpg",
          contentType: 1,
          isDeleted: false,
          usersViewed: ["apande", "anon", "artwan", "kamau", "kenn"],
          usersLiked: ["apande", "anon", "artwan"],
          creationTime: DateTime.now().subtract(Duration(hours: 23)),
        ),
        StatusModel(
          contentLink: "assets/media/1.mp4",
          contentType: 2,
          isDeleted: false,
          usersViewed: ["apande", "anon", "artwan", "kamau", "kenn"],
          usersLiked: ["apande", "anon", "artwan"],
          creationTime: DateTime.now().subtract(Duration(hours: 23)),
        ),
        StatusModel(
          contentLink: "assets/media/3.mp4",
          contentType: 2,
          isDeleted: false,
          usersViewed: ["apande", "anon", "artwan", "kamau", "kenn"],
          usersLiked: ["apande", "anon", "artwan"],
          creationTime: DateTime.now().subtract(Duration(hours: 23)),
        ),
      ],
      userAllowedToView: [],
      userblocked: [],
      creationTime: DateTime.now().subtract(Duration(hours: 5)),
      updateTime: DateTime.now().subtract(Duration(hours: 5))),
];
