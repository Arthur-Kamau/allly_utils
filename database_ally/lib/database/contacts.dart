
import 'package:database_ally/core/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDB{
   

//get alll Contact
  Future<List<Contact>> getAllContact(Database dbConnection) async {
    String sql = "SELECT * FROM  Contact";
    
    List<Map> list = await dbConnection.rawQuery(sql);
    List<Contact> ContactAll = new List();
    for (var i = 0; i < list.length; i++) {
      Contact contact = new Contact(
        name:  list[i]['name'],
        phoneNumber: list[i]['phone_number'],
      );
    
      ContactAll.add(contact);
    }
    return ContactAll;
  }

  //add new contact
  void addContact(Contact contact,Database dbConnection) async {
  
    String sql =
        "INSERT INTO Contact(name,phone_number) VALUES ('${contact.name}', '${contact.phoneNumber}') ";

    await dbConnection.transaction((transaction) async {
      return await transaction.rawInsert(sql);
    });
  }
  
}