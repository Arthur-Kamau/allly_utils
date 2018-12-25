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

enum StatusChatEnumModel{
 deleted,
 viewed,
 sent,
 sending
}
class ChatModel{

  int id;
  String chatId;
  String recipient;
  String sender;
  StatusChatEnumModel status;
  DateTime createdAt;
  DateTime updatedAt;

}

