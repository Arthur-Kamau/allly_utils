import 'dart:async';
import 'dart:io' as io;
import 'package:ally_chat/model/chat_history_model.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class ChatMetaData {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  //Creating a database with name test.dn in your directory
  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "History.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  // Creating a table name AuthDetails with fields
  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute("""
        CREATE TABLE ChatHistoryData(
          id INTEGER PRIMARY KEY,
         
          chattype INTEGER, 
          chatId TEXT, 
          senderId TEXT, 
          recepientId TEXT,

          senderPhoneNumber TEXT,
          groupName TEXT,
          groupId TEXT,

          status INTEGER,
          lastMessage TEXT,
          numberMessage TEXT,
          avatarUrl TEXT,

          createTime TEXT,
          updateTime TEXT
        )
        """);
    print("Created tables");
  }

  // Retrieving AuthDetailss from AuthDetails Tables
  Future<List<ChatHistoryModel>> getChatHistoryDetails() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM ChatHistoryData ');

    List<ChatHistoryModel> chatHistoryDetails = new List();
    if (list.length > 0) {
      print("data $list");

      for (int i = 0; i < list.length; i++) {
        chatHistoryDetails.add(ChatHistoryModel(

            //int id
            id: int.parse(list[i]["id"]),
            //int chattype
            chattype: int.parse(list[i]["id"]),
            senderId: list[i]["senderId"],
            recepientId: list[i]["recepientId"],
            senderPhoneNumber: list[i]["senderPhoneNumber"],
            groupName: list[i]["groupName"],
            groupId: list[i]["groupId"],
            //get if the message is seen or not
            status: int.parse(list[i]["status"]),
            //specific id for the chat
            chatId: list[i]["chatId"],
            numberMessage: list[i]["numberMessage"],
            lastMessage: list[i]["lastMessage"],
            avatarUrl: list[i]["avatarUrl"],
            createTime: DateTime.parse(list[i]["createTime"]),
            updateTime: DateTime.parse(list[i]["updateTime"])));
      }
      //print length just to confirm
      print(chatHistoryDetails.length);

      return chatHistoryDetails;
    } else {
      return chatHistoryDetails;
    }
  }

  void saveChatHistoryDetails(ChatHistoryModel chatItem) async {
    var dbClient = await db;
    String query = " INSERT INTO ChatHistoryData " +
        " (" +
        " chattype ,chatId ,senderId ," +
        "    recepientId , senderPhoneNumber ,groupName ," +
        "   groupId , status , lastMessage ," +
        "   numberMessage ,avatarUrl , createTime ,updateTime  " +
        " ) VALUES(" +
        "     '0','id','sender_id'," +
        "    'recepientId' , 'senderPhoneNumber' , 'groupName' ," +
        "    'groupId', 'status' , 'lastMessage' ," +
        "    'numberMessage' , 'avatarUrl' , 'createTime' ,'updateTime'" +
        "  )";
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(query);
    });
  }

  void deleteChatData(String senderId,String createTime) async {
    var dbClient = await db;
    // dbClient.rawDelete("DELETE * FROM AuthDetails");
    dbClient.rawDelete(" DELETE FROM ChatHistoryData WHERE senderId= $senderId AND createTime = $createTime ");
    // await dbClient.transaction((txn) async {
    //   return await txn.rawDelete("DELETE * FROM AuthDetails");
    // });
  }
}
