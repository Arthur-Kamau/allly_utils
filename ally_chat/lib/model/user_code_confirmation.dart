class UserCodeConfirmationModel {
  int id;
  bool aunthentified;
  String token;
  String name;
 

  UserCodeConfirmationModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        aunthentified = json['aunthentified'],
        token = json['token'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'aunthentified' : aunthentified,
        'token': token,
        'code': name,
      };
}
