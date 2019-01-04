import 'dart:async';
import 'dart:io' as io;
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
    String path = join(documentsDirectory.path, "meta.db");
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
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM AuthDetails ');
    //WHERE deviceId=' + deviceId);
    if (list.length > 0) {
      print("data $list");
      List<AuthDetails> auth_details = new List();
      for (int i = 0; i < list.length; i++) {
        auth_details.add(AuthDetails(
          authStatus: int.parse(list[i]["authStatus"]),
          authTime: DateTime.parse(list[i]["authTime"]),
          authtoken: list[i]["authToken"],
          deviceId: list[i]["deviceId"],
        ));
      }
      print(auth_details.length);

      return auth_details[0];
    } else {
      return AuthDetails(
          authStatus: 0, authTime: DateTime.now(), deviceId: "", authtoken: "");
    }
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

  void deleteUserDetails() async {
    var dbClient = await db;
    // dbClient.rawDelete("DELETE * FROM AuthDetails");
    dbClient.rawDelete(" DELETE FROM AuthDetails WHERE id = 1");
    // await dbClient.transaction((txn) async {
    //   return await txn.rawDelete("DELETE * FROM AuthDetails");
    // });
  }
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
