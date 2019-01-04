class UserCodeConfirmationModel {
  int id;
  String token;
  String code;
  DateTime createdAt;
  DateTime updatedAt;

  UserCodeConfirmationModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        token = json['token'],
        code = json['code'],
        createdAt = json['create_at'],
        updatedAt = json['update_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'token': token,
        'code': code,
        'create_at': createdAt,
        'update_at': updatedAt
      };
}
