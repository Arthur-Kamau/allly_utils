class ChannelChatModel {
  int id;
  String channeChatId;
  String channelId;
  String comment;
  String commentParent;
  String sender;
  String userAvatar;

  DateTime createdAt;
  DateTime updatedAt;

  ChannelChatModel(
      {this.id,
      this.channeChatId,
      this.channelId,
      this.comment,
      this.commentParent,
      this.sender,
      this.userAvatar,
      this.createdAt,
      this.updatedAt});

  ChannelChatModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        channeChatId = json['channel_chat_id'],
        channelId = json['channel_id'],
        comment = json['comment'],
        commentParent = json['comment_parent'],
        sender = json['sender'],
        userAvatar = json['user_avatar'],
        createdAt = json['create_at'],
        updatedAt = json['update_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'channel_chat_id': channeChatId,
        'channel_id': channelId,

         'comment': comment,
        'comment_parent': commentParent,

          'sender': sender,
        'user_avatar': userAvatar,

        'create_at': createdAt,
        'update_at': updatedAt
      };
}
