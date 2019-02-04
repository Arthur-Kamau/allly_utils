/*
  * model snake case.
  * class Camel case
*/

class PokeHistoryModel {
  final int id;
  final String name;
  final String status;
  final String number;
  final String avatarUrl;
  final DateTime createTime;
  final DateTime updateTime;

  PokeHistoryModel(
      {this.id,
      this.name,
      this.status,
      this.number,
      this.avatarUrl,
      this.createTime,
      this.updateTime});

  PokeHistoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        status = json['status'],
        number = json['number'],
        avatarUrl = json['avatar_url'],
        createTime = json['create_at'],
        updateTime = json['update_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'status': status,
        'number': number,
        'avatar_url': avatarUrl,
        'create_at': createTime,
        'update_at': updateTime
      };
}

List<PokeHistoryModel> dummyData = [
  new PokeHistoryModel(
      id: 1,
      name: "Jimmy",
      status: "message item here",
      number: "12",
      avatarUrl: "assets/images/0.png",
      createTime: DateTime.now(),
      updateTime: DateTime.now()),
  new PokeHistoryModel(
      id: 2,
      name: "Ester",
      status: "message item here",
      number: "12",
      avatarUrl: "assets/images/1.png",
      createTime: DateTime.now().subtract(Duration(days: 10)),
      updateTime: DateTime.now())
];
