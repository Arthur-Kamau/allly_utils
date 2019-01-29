/*
  * model snake case.
  * class Camel case

    //details
    ->id (int auto increment)
    ->contact details
    ->status (has app,)

    statusContactHasApp = 0 ==> not known
    statusContactHasApp = 1 ==> use has app
    statusContactHasApp = 2 ==>user does not have name.
  
*/

class ContactModel {
  int id;

  String avatar;
  String name;
  String mssidn;
  String email;
  String userId;
  bool isselected;
  int statusContactHasApp;
  DateTime createdAt;
  DateTime updatedAt;

  ContactModel(
      {this.avatar,
      this.name,
      this.mssidn,
      this.userId,
      this.email,
      this.isselected,
      this.statusContactHasApp,
      this.createdAt,
      this.updatedAt});

  ContactModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        mssidn = json['mssidn'],
        userId = json['userId'],
        email = json['email'],
        isselected = json['is_selected'],
        statusContactHasApp = json['contact_has_app'],
        createdAt = json['create_at'],
        updatedAt = json['update_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'mssidn': mssidn,
        'user_id': userId,
        'email': email,
        'is_selected': isselected,
        'contact_has_app': statusContactHasApp,
        'create_at': createdAt,
        'update_at': updatedAt
      };
}

var dummyContact = [
  ContactModel(
    avatar: "",
    name: "kamau sender",
    mssidn: "0784900505912",
    userId: "0987",
    isselected: false,
    statusContactHasApp: 0,
    createdAt: DateTime.now().subtract(Duration(hours: 20)),
    updatedAt: DateTime.now().subtract(Duration(hours: 10)),
  ),
  ContactModel(
    avatar: "assets/images/0.png",
    name: "Mike",
    userId: "",
    mssidn: "07092929505912",
    isselected: false,
    statusContactHasApp: 1,
    createdAt: DateTime.now().subtract(Duration(hours: 100)),
    updatedAt: DateTime.now().subtract(Duration(hours: 20)),
  ),
  ContactModel(
    avatar: "",
    name: "Ester",
    userId: "120",
    mssidn: "07092929505912",
    isselected: false,
    statusContactHasApp: 0,
    createdAt: DateTime.now().subtract(Duration(hours: 1000)),
    updatedAt: DateTime.now().subtract(Duration(hours: 0)),
  ),
];
