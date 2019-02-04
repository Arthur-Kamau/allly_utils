import 'package:ally_chat/database/query.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io' as io;

class AllyNativeDb {
  //one instance of db
  static Database db_instance;

  Future<Database>  db() async {
    if (db_instance == null) {
      db_instance = await initDb();
      return db_instance;
    } else {
      return db_instance;
    }
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "ally.db");
    var db = await openDatabase(path, version: 1, onCreate: onCreateFunc);
    return db;
  }

  void onCreateFunc(Database db, int version) async {
    //create the tables
    print("\n\n Create tables \n\n");
    //contact list
    await db.execute(Query.contactCreateQuery);
    //blocked contact list
    await db.execute(Query.blockedContactCreateQuery);
    
    //users profile table
    await db.execute(Query.userAccountProfileCreateQuery);
    //groups table
    await db.execute(Query.groupsTable);
    //mail table
    await db.execute(Query.mailTable);
    //style table
    await db.execute(Query.styleTable);
    //status table
    await db.execute(Query.statusTable);
    //user status table
    await db.execute(Query.userStatusTable);
    //p2p table
    await db.execute(Query.chatsP2PTable);
    //p2g table
    await db.execute(Query.chatsP2GTable);
    //poke table
    await db.execute(Query.chatsPoketable);
    //channels table
    await db.execute(Query.channelsTable);
    //logged in table
    await db.execute(Query.loggedInTable);

    print("\n\n\n Creating tables \n\n\n");
  }
}
