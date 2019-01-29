import 'package:database_ally/core/contact.dart';

import 'package:sqflite/sqflite.dart';

class BlockedContactDB {
//get alll Contact
  Future<List<Contact>> getAllContactsBlocked(Database db) async {
    String sql = "SELECT * FROM  blocked_Contact";
    var dbConnection = await db;
    List<Map> list = await dbConnection.rawQuery(sql);
    List<Contact> contactAll = new List();
    for (var i = 0; i < list.length; i++) {
      Contact contact = new Contact(
          name: list[i]['name'], phoneNumber: list[i]['phone_number']);
      //  contact.id = list[i]['id'];
      // contact.name = list[i]['name'];
      // contact.phoneNumber = list[i]['phone_number'];
      contactAll.add(contact);
    }
    return contactAll;
  }

  //add new contact
  void addContact(Contact contact, Database dbConnection) async {
    String sql =
        "INSERT INTO blocked_Contact(name,phone_number) VALUES ('${contact.name}', '${contact.phoneNumber}') ";

    await dbConnection.transaction((transaction) async {
      return await transaction.rawInsert(sql);
    });
  }

  //remove a contact
  void removeAContact(Contact contact, Database dbConnection) async {
    await dbConnection.rawDelete(
        'DELETE FROM blocked_Contact WHERE name = ?', [contact.name]);
  }
}
