import 'dart:async';
import 'dart:io' as io;
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class AuthData {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  //Creating a database with name test.dn in your directory
  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "data.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  // Creating a table name AuthDetails with fields
  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE AuthDetails(id INTEGER PRIMARY KEY, authToken TEXT, authStatus TEXT, authTime TEXT,deviceId TEXT )");
    print("Created tables");
  }

  // Retrieving AuthDetailss from AuthDetails Tables
  Future<AuthDetails> getAuthDetails() async {
    /*AuthDetails*/
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM AuthDetails ');
    //WHERE deviceId=' + deviceId);

    print("data $list");

    return AuthDetails();
    // List<AuthDetails> AuthDetailss = new List();
    // for (int i = 0; i < list.length; i++) {
    //   AuthDetailss.add(new AuthDetails(list[i]["firstname"], list[i]["lastname"],
    //       list[i]["mobileno"], list[i]["emailid"]));
    // }
    // print(AuthDetailss.length);
    // return AuthDetails;
  }

  void saveAuthDetails(AuthDetails userDetails) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO AuthDetails(authStatus, authToken, authTime, deviceId ) VALUES(' +
              '\'' +
              userDetails.authStatus.toString() +
              '\'' +
              ',' +
              '\'' +
              userDetails.authtoken +
              '\'' +
              ',' +
              '\'' +
              userDetails.authTime.toString() +
              '\'' +
              ',' +
              '\'' +
              userDetails.deviceId +
              '\'' +
              ')');
    });
  }

  void deleteUserDetails() {}
}

class AuthDetails {
  final String authtoken;
  final DateTime authTime;
  final int authStatus;
  final String deviceId;

  AuthDetails(
      {@required this.authStatus,
      @required this.authtoken,
      @required this.authTime,
      @required this.deviceId});
}
