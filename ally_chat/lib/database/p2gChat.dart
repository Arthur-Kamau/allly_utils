
import 'package:ally_chat/model/operations_models/chat_model.dart';
import 'package:ally_chat/model/operations_models/contact_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io' as io;

class P2GDB {
/**
 * get contacts
 */
  Future<List<ChatP2GModel>> getp2gChats(Database db, String groupId) async {
    String getContactsQuery =
        "SELECT * FROM chat_p2g_table WHERE  groupId=$groupId";

    List<Map> dbList = await db.rawQuery(getContactsQuery);
    List<ChatP2GModel> chats = new List();

    for (var i = 0; i < dbList.length; i++) {
      ChatP2GModel achat = ChatP2GModel();

      achat.id = dbList[i]['id'];

      achat.senderId = dbList[i]['senderId'];

      achat.groupId = dbList[i]['groupId'];
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

  void addp2gChat(ChatP2GModel achat, Database db) async {
    String query = """
      INSERT INTO chat_p2p_table (

        statusType,

        groupId ,
        senderPhoneNumber,
        senderPublicName  ,
        senderId ,

        
        MessageStatus  ,
        ContentType ,
        Content ,

        createdAt  ,
        updatedAt 

        )
      VALUES (
        ${achat.statusType},
        ${achat.senderPhoneNumber}
        ${achat.senderPublicName},
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

  void deleteAChat(ChatP2GModel achat, Database db) async {
    String query = """DELETE FROM chat_p2p_table
         WHERE createdAt= ${achat.createTime},
            senderId  = ${achat.senderId}
            and
   ChatId = ${achat.groupId}""";

    await db.transaction((transaction) async {
      return await transaction.rawDelete(query);
    });
  }
}
