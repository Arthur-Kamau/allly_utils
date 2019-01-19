/**
* int chat type
  *chat type
    0 => p2p
    1 => peer/person to group
*
* int chat status type
*	 0->Sending
*	 1->Received
*	 2->Deleted

*
* int message status type
  0->unseen
  1->seen
*
* int content type
*	 0 -> text
*	 1	-> Image
*	 2  ->Video
*	 3   ->Location(Maps)

 */

class ChatModel {
  int id;
  List<ChatP2GModel> person_to_group;
  List<ChatP2PModel> person_to_person;
  List<ChatPokeModel> person_to_poke;

  ChatModel({
    this.id,
    this.person_to_group,
    this.person_to_person,
    this.person_to_poke,
  });
}

ChatModel chattData = new ChatModel(
  id: 1,
  person_to_group: chattDataP2G,
  person_to_person: chattDataP2P,
);

class ChatP2PModel {
  int id;
  String recepientId;
  String senderId;
  String chatId;
  String senderphoneNumber;
  int statusType;
  int messageStatus;
  int contentType;
  String content;
  DateTime createTime;
  DateTime updateTime;


  ChatP2PModel(
      {this.id,
      this.recepientId,
      this.senderId,
      this.statusType,
      this.chatId,
      this.senderphoneNumber,
      this.messageStatus,
      this.contentType,
      this.content,
      this.createTime,
      this.updateTime});

  ChatP2PModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        recepientId = json['recepient_id'],
        senderId = json['sender_id'],
        statusType = json['status_type'],
        chatId = json['chat_id'],
        senderphoneNumber = json['sender_phone_number'],
        messageStatus = json['message_status'],
        contentType = json['content_type'],
        createTime = json['create_at'],
        updateTime = json['update_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'recepient_id': recepientId,
        'sender_id': senderId,
        'status_type': statusType,
        'chat_id': chatId,
        'sender_phone_number': senderphoneNumber,
        'message_status': messageStatus,
        'content_type': contentType,
        'create_at': createTime,
        'update_at': updateTime
      };
}

class ChatP2GModel {
  int id;

  String senderPhoneNumber;
  String senderPublicName;
  String senderId;

  String groupId;

  int statusType;
  int messageStatus;
  int contentType;
  String content;

  DateTime createTime;
  DateTime updateTime;


  ChatP2GModel(
      {this.id,
      this.senderPhoneNumber,
      this.senderPublicName,
      this.senderId,
      this.groupId,
      this.statusType,
      this.messageStatus,
      this.contentType,
      this.content,
      this.createTime,
      this.updateTime});

        ChatP2GModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        senderPhoneNumber = json['sender_phone_number'],
        senderPublicName = json['sender_public_name'],
        statusType = json['status_type'],
        senderId = json['sender_id'],
        groupId = json['group_id'],
        messageStatus = json['message_status'],
        contentType = json['content_type'],
        content = json['content'],
        
        createTime = json['create_at'],
        updateTime = json['update_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'sender_phone_number': senderPhoneNumber,
        'sender_public_name': senderPublicName
        ,
        'status_type': statusType,
        'sender_id': senderId,
        'group_id': groupId,
        'message_status': messageStatus,

        'content_type': contentType,
        'content': content,
        'create_at': createTime,
        'update_at': updateTime
      };
}

class ChatPokeModel {
  int id;

  String recepientId;
  String senderId;
  String senderName;

  String chatId;

  int statusType;
  int messageStatus;
  int contentType;
  String content;

  DateTime createTime;
  DateTime updateTime;

  ChatPokeModel(
      {this.id,
      this.recepientId,
      this.senderId,
      this.senderName,
      this.statusType,
      this.chatId,
      this.messageStatus,
      this.contentType,
      this.content,
      this.createTime,
      this.updateTime});

       ChatPokeModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        recepientId = json['recepient_id'],
        senderId = json['sender_id'],
        statusType = json['status_type'],
        senderName = json['sender_name'],
        chatId = json['group_id'],
        messageStatus = json['message_status'],
        contentType = json['content_type'],
        content = json['content'],
        
        createTime = json['create_at'],
        updateTime = json['update_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'recepient_id': recepientId,
        'sender_id': senderId,

        'status_type': statusType,
        'chat_id': chatId,

        'sender_name': senderName,
        'message_status': messageStatus,

        'content_type': contentType,
        'content': content,
        'create_at': createTime,
        'update_at': updateTime
      };
}

List<ChatP2PModel> chattDataP2P = [
  new ChatP2PModel(
      id: 1,
      recepientId: "12345",
      senderId: "09983",
      statusType: 0,
      chatId: "1234",
      messageStatus: 0,
      contentType: 0,
      content: "hell0 there kenn",
      createTime: DateTime.now().subtract(Duration(hours: 6)),
      updateTime: DateTime.now().subtract(Duration(hours: 6))),
  new ChatP2PModel(
      id: 1,
      recepientId: "09983",
      senderId: "12345",
      statusType: 0,
      chatId: "1234",
      messageStatus: 0,
      contentType: 0,
      content: "hell0 there kamau",
      createTime: DateTime.now().subtract(Duration(hours: 5)),
      updateTime: DateTime.now().subtract(Duration(hours: 5))),
  new ChatP2PModel(
      id: 1,
      recepientId: "",
      senderId: "",
      statusType: 0,
      senderphoneNumber: "102993893",
      chatId: "1234",
      messageStatus: 0,
      contentType: 0,
      content: "i am great kamau",
      createTime: DateTime.now().subtract(Duration(hours: 4, minutes: 55)),
      updateTime: DateTime.now().subtract(Duration(hours: 4, minutes: 55))),
  new ChatP2PModel(
      id: 1,
      recepientId: "",
      senderId: "",
      statusType: 0,
     senderphoneNumber:  "102993893",
      chatId: "1234",
      messageStatus: 0,
      contentType: 1,
      content:
          "https://images.pexels.com/photos/935969/pexels-photo-935969.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      createTime: DateTime.now().subtract(Duration(hours: 4, minutes: 40)),
      updateTime: DateTime.now().subtract(Duration(hours: 4, minutes: 40))),
];

List<ChatP2GModel> chattDataP2G = [
  new ChatP2GModel(
      id: 1,
      senderPhoneNumber: "0717008240",
      senderPublicName: "kamajajha",
      senderId: "09983",
      groupId: "1234",
      statusType: 0,
      messageStatus: 0,
      contentType: 0,
      content: "hell0 there kamau",
      createTime: DateTime.now().subtract(Duration(hours: 6)),
      updateTime: DateTime.now().subtract(Duration(hours: 6))),
  new ChatP2GModel(
      id: 2,
      senderPhoneNumber: "0717008240",
      senderPublicName: "kamajajha",
      senderId: "09983",
      groupId: "1234",
      statusType: 0,
      messageStatus: 0,
      contentType: 0,
      content: "hell0 there kamau",
      createTime: DateTime.now().subtract(Duration(hours: 5)),
      updateTime: DateTime.now().subtract(Duration(hours: 5))),
  new ChatP2GModel(
      id: 3,
      senderPhoneNumber: "0717008240",
      senderPublicName: "kamajajha",
      senderId: "09983",
      groupId: "1234",
      statusType: 0,
      messageStatus: 0,
      contentType: 0,
      content: "hell0 there kamau",
      createTime: DateTime.now().subtract(Duration(hours: 4, minutes: 55)),
      updateTime: DateTime.now().subtract(Duration(hours: 4, minutes: 55))),
  new ChatP2GModel(
      id: 1,
      senderPhoneNumber: "0717008240",
      senderPublicName: "kamajajha",
      senderId: "09983",
      groupId: "1234",
      statusType: 0,
      messageStatus: 0,
      contentType: 1,
      content:
          "https://images.pexels.com/photos/935969/pexels-photo-935969.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      createTime: DateTime.now().subtract(Duration(hours: 4, minutes: 40)),
      updateTime: DateTime.now().subtract(Duration(hours: 4, minutes: 40))),
];
