import 'dart:async';
import 'dart:io' as io;
import 'package:ally_chat/database/query.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class AllyDatabase {
  static Database db_instance;

  Future<Database> get db async {
    if (db_instance == null) {
      db_instance = await initDB();
    }
    return db_instance;
  }

  Future<Database> initDB() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "Ally_db");
    var db = await openDatabase(path, version: 1, onCreate: createDatabase);
    return db;
  }

  void createDatabase(Database db, int version) async {

       //create the tables
    print("\n\n Create tables \n\n");
    
    await db.execute(Query.contactCreateQuery);
    await db.execute(Query.blockedContactCreateQuery);
    await db.execute(Query.userAccountProfileCreateQuery);

    //contact list
    await db.execute(Query.contactCreateQuery);
    //blocked contact list
    await db.execute(Query.blockedContactCreateQuery);

    //users profile table
    await db.execute(Query.userAccountProfileCreateQuery);
    //groups table
    await db.execute(Query.groupsTable);

    await db.execute(Query.chatsP2PTable);
    //p2g table
    await db.execute(Query.chatsP2GTable);

    //logged in table
    await db.execute(Query.loggedInTable);

    
    //mail table
    //await db.execute(Query.mailTable);
    //style table
    //await db.execute(Query.styleTable);
    //status table
    //await db.execute(Query.statusTable);
    //user status table
    //await db.execute(Query.userStatusTable);
    //p2p table

    //poke table
    //await db.execute(Query.chatsPoketable);
    //channels table
    //await db.execute(Query.channelsTable);

    print("\n\n\n Creating tables \n\n\n");
  }
}
