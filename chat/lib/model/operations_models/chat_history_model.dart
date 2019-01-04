/*
  * model snake case.
  * class Camel case

  *chat type
    0 => p2p
    1 => peer/person to group

*/

class ChatHistoryModel {
  final int id;
  final int chattype;
  final String chatId;
  final String senderId;
  final String recepientId;
  final String phoneNumber; // if  chattype ==  0 interchangeable with groupName
  final String groupName; //if chattype ==1   interchangeable with phoneNumber
  final String groupId;
  final String status;
  final String lastMessage;
  final String number;
  final String avatarUrl;
  final DateTime createTime;
  final DateTime updateTime;

  ChatHistoryModel(
      {this.id,
      this.chattype,
      this.senderId,
      this.recepientId,
      this.phoneNumber,
      this.groupName,
      this.groupId,
      this.status,
      this.chatId,
      this.number,
      this.lastMessage,
      this.avatarUrl,
      this.createTime,
      this.updateTime});

  ChatHistoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        chattype = json['chat_type'],
        senderId = json['sender_id'],
        recepientId = json['recepient_id'],
        phoneNumber = json['phone_number'],
        groupId = json['group_id'],
        status = json['status'],
        chatId = json['chat_id'],
        groupName = json['group_name'],
        number = json['number'],
        avatarUrl = json['avatar_url'],
        lastMessage = json['last_message'],
        createTime = json['create_at'],
        updateTime = json['update_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'chat_type': chattype,
        'sender_id': senderId,
        'recepient_id': recepientId,
        'phone_number': phoneNumber,
        'group_id': groupId,
        'status': status,
        'chat_id': chatId,
        'group_name': groupName,
        'number': number,
        'avatar_url': avatarUrl,
        'last_message': lastMessage,
        'create_at': createTime,
        'update_at': updateTime
      };
}

List<ChatHistoryModel> dummyData = [
  new ChatHistoryModel(
      id: 1,
      chattype: 0,
      senderId: "0987",
      recepientId: "567",
      phoneNumber: "082929229",
      status: "message item here",
      chatId: "1234",
      number: "12",
      avatarUrl: "assets/images/0.png",
      createTime: DateTime.now(),
      updateTime: DateTime.now()),
  new ChatHistoryModel(
      id: 2,
      chattype: 1,
      senderId: "49448489",
      recepientId: "567",
      groupName: "Christ the king",
      groupId: "9990",
      status: "message item here",
      chatId: "34550",
      number: "12",
      avatarUrl: "assets/images/1.png",
      createTime: DateTime.now(),
      updateTime: DateTime.now()),
  new ChatHistoryModel(
      id: 3,
      chattype: 1,
      senderId: "2992",
      recepientId: "567",
      groupName: "urban trends",
      groupId: "0999",
      status: "message item here",
      chatId: "303039",
      number: "12",
      avatarUrl: "assets/images/2.png",
      createTime: DateTime.now().subtract(Duration(days: 5)),
      updateTime: DateTime.now()),
  new ChatHistoryModel(
      id: 1,
      chattype: 0,
      senderId: "iwieiw ",
      recepientId: "567",
      phoneNumber: "082929229",
      status: "message item here",
      chatId: "2200e94e",
      number: "12",
      avatarUrl: "assets/images/3.png",
      createTime: DateTime.now().subtract(Duration(days: 1)),
      updateTime: DateTime.now()),
  new ChatHistoryModel(
      id: 2,
      chattype: 1,
      senderId: "akaak",
      recepientId: "567",
      groupName: "Holy Trinity",
      groupId: "99008",
      status: "message item here",
      chatId: "9ee00e8",
      number: "202",
      avatarUrl: "assets/images/1.png",
      createTime: DateTime.now().subtract(Duration(days: 10)),
      updateTime: DateTime.now())
];
