
import 'package:chat/model/operations_models/chat_model.dart';

class HomePageViewModel {
  final int numberOFNewMail;
  final int numberOfChannels;
  final int numberOfNewChats;
  final int numberOfNewMessages;
  final String welcomeMessage;
  ChatModel chats;


  HomePageViewModel({
    this.numberOFNewMail,
    this.numberOfChannels,
    this.numberOfNewChats,
    this.numberOfNewMessages,
    this.welcomeMessage,
    this.chats
    });
}
