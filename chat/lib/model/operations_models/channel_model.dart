/*
  * model snake case.
  * class Camel case

  //contents
  -> id mandatory field (primary key)
  ->chat id (a chat can be p2p or to a bot)
  ->recipient (to receive the message/chat)
  ->from/sender (person/bot sending the message)
  ->DateTime created at (when the message was sent/detected by vps)
  ->DateTime updated at (when the message was sent/detected by vps)
  ->Content type (image/video/text/meme/)
  ->Status an enum (deleted/viewed/sent/sending)
*/

class ChannelModel {
  int id;
  String owneruserId;
  String title;
  String channelId;
  String channelAvatar;
  bool notifyOthers;
  List<String> subscribers;
  List<String> channelSubscribedto;

  DateTime createdAt;
  DateTime updatedAt;

  ChannelModel({
    this.id,
    this.owneruserId,
    this.title,
    this.channelId,
    this.channelAvatar,
    this.notifyOthers,
    this.channelSubscribedto,
    this.subscribers,
    this.createdAt,
    this.updatedAt,
  });

  ChannelModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        owneruserId = json['owner_user_id'],
        title = json['title'],
        channelId = json['channel_id'],
        channelAvatar = json['channel_avatar'],
        notifyOthers = json['notify_others'],
        channelSubscribedto = json['channel_subscribed_to'],
        subscribers = json['subscribers'],
        createdAt = json['create_at'],
        updatedAt = json['update_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'owneruserId': owneruserId,
        'title': title,
        'channel_id': channelId,
        'channel_avatar': channelAvatar,
        'notify_others': notifyOthers,
        'channel_subscribed_to': channelSubscribedto,
        'subscribers': subscribers,
        'email': createdAt,
        'update_at': updatedAt
      };
}

var myChannel = new ChannelModel(
  id: 1,
  owneruserId: "12345",
  title: "Graduatuion",
  channelId: "12345",
  channelAvatar: "assets/images/0.png",
  notifyOthers: true,
  channelSubscribedto: ["1234", "12394"],
  subscribers: ["q992", "9w9w"],
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

List<ChannelModel> channelData = [
  new ChannelModel(
    id: 1,
    owneruserId: "282293030",
    title: "Graduatuion",
    channelId: "12345",
    channelAvatar: "assets/images/0.png",
    notifyOthers: true,
    channelSubscribedto: ["1234", "12394"],
    subscribers: ["q992", "9w9w"],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  new ChannelModel(
    id: 1,
    owneruserId: "12345",
    title: "Wedding",
    channelId: "12345",
    channelAvatar: "assets/images/1.png",
    channelSubscribedto: ["12394", "172394"],
    subscribers: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  )
];
