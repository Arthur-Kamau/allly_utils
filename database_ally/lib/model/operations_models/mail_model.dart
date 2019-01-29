/*
  * model snake case.
  * class Camel case
*/

class MailModel {
  final int id;
  final String mailTitle;
  final String mailContent;
  final DateTime createTime;
  final DateTime updateTime;

  MailModel(
      {this.id,
      this.mailTitle,
      this.mailContent,
      this.createTime,
      this.updateTime});

  MailModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        mailTitle = json['mail_title'],
        mailContent = json['mail_content'],
        createTime = json['create_at'],
        updateTime = json['update_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'mail_title': mailTitle,
        'mail_content': mailContent,
        'create_at': createTime,
        'update_at': updateTime
      };
}

List<MailModel> dummyData = [
  new MailModel(
      id: 1,
      mailTitle: "New Update",
      mailContent:
          """Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a 
        galley of type and scrambled it to make a type specimen book. It has """,
      createTime: DateTime.now(),
      updateTime: DateTime.now()),
  new MailModel(
      id: 1,
      mailTitle: "Give feedback",
      mailContent:
          """Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a 
        galley of type and scrambled it to make a type specimen book. It has """,
      createTime: DateTime.now(),
      updateTime: DateTime.now()),
  new MailModel(
      id: 1,
      mailTitle: "Welcome",
      mailContent:
          """Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a 
        galley of type and scrambled it to make a type specimen book. It has """,
      createTime: DateTime.now().subtract(Duration(days: 5)),
      updateTime: DateTime.now()),
];
