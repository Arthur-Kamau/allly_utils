import 'dart:async';
import 'dart:io' as io;
import 'package:database_ally/database/query.dart';
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
    await db.execute(QUERY.ContactCreateQuery);
    await db.execute(QUERY.blockedContactCreateQuery);
  }
}
