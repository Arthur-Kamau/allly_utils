
import 'package:ally_chat/model/operations_models/chat_model.dart';
import 'package:ally_chat/model/operations_models/contact_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io' as io;

class P2PDB {
/**
 * get contacts
 */
  Future<List<ChatP2PModel>> getp2pChats(Database db, String chatId) async {
    String getContactsQuery =
        "SELECT * FROM chat_p2p_table WHERE  ChatId=$chatId";

    List<Map> dbList = await db.rawQuery(getContactsQuery);
    List<ChatP2PModel> chats = new List();

    for (var i = 0; i < dbList.length; i++) {
      ChatP2PModel achat = ChatP2PModel();

      achat.id = dbList[i]['id'];

      achat.senderId = dbList[i]['senderId'];

      achat.chatId = dbList[i]['ChatId'];
      achat.statusType = dbList[i]['statusType'];

      achat.messageStatus = dbList[i]['messageStatus'];
      achat.contentType = dbList[i]['contentType'];
      achat.content = dbList[i]['content'];

      achat.createTime = dbList[i]['createdAt'];
      achat.updateTime = dbList[i]['updatedAt'];

      chats.add(achat);
    }

    return chats;
  }

  /**
   * insert contacts_blocked
   */

  void addp2pChat(ChatP2PModel achat, Database db) async {
    String query = """
      INSERT INTO chat_p2p_table (

statusType,
phoneNumber,

		ChatId ,
		RecepientId  ,
		SenderId ,

		
		MessageStatus  ,
		ContentType ,
		Content ,

 createdAt  ,
    updatedAt 

        )
      VALUES (
        ${achat.statusType},
        ${achat.phoneNumber}
        ${achat.chatId},
        ${achat.recepientId},
        ${achat.senderId},
        
          ${achat.messageStatus},
        ${achat.contentType},

          ${achat.content}
        ${achat.createTime},
        ${achat.updateTime},
    """;

    await db.transaction((transaction) async {
      return await transaction.rawInsert(query);
    });
  }

  /**
   * update message seen
   * * int message status type
  0->unseen
  1->seen
   */

  void updateUserHasViewed(String ChatId, Database db) async {
    int seen = 1;
    String query = """"
        UPDATE  chat_p2p_table
        SET  messageStatus = $seen
         WHERE ChatId= $ChatId
        """;

    await db.transaction((transaction) async {
      return await transaction.rawUpdate(query);
    });
  }

  /**
   * delete chat
   */

  void deleteAChat(ChatP2PModel achat, Database db) async {
    String query = """DELETE FROM chat_p2p_table
         WHERE createdAt= ${achat.createTime},
            senderId  = ${achat.senderId}
            and
   ChatId = ${achat.chatId}""";

    await db.transaction((transaction) async {
      return await transaction.rawDelete(query);
    });
  }
}
