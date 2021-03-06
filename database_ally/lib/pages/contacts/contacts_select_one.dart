import 'package:database_ally/core/contact.dart';
import 'package:database_ally/core/user.dart';
import 'package:database_ally/database/contacts.dart';
import 'package:database_ally/database/database.dart';
import 'package:database_ally/pages/blocked/blocked.dart';
// import 'package:database_ally/pages/chat/chat_history.dart';
// import 'package:database_ally/pages/person/person_chat_view.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

//intent one ->chat history
//        two ->chat item
//        three ->blocked Contact

class ContactSelectOne extends StatefulWidget {
  static String tag = 'Contact-select-one-page';
  int intent;
  ContactSelectOne({@required this.intent});

  @override
  ContactSelectOneState createState() {
    return new ContactSelectOneState();
  }
}

class ContactSelectOneState extends State<ContactSelectOne> {
  static const platform = const MethodChannel('com.araizen/modules/utils');

  Future<Map<dynamic, dynamic>> _getContact() async {
    Map<dynamic, dynamic> _conts = {};

    try {
      _conts =
          await platform.invokeMethod('getContacts') as Map<dynamic, dynamic>;
    } on PlatformException catch (e) {
      print("\n\n Failed to get ciontacts : '${e.message}'. \n\n");
    }

    return _conts;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    Map<dynamic, dynamic> values = snapshot.data;

    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        String key = values.keys.elementAt(index);
        return new Column(
          children: <Widget>[
            new ListTile(
              title: new Text("$key"),
              subtitle: new Text("${values[key]}"),
              onTap: () {
                print("pop item contact");
                //Navigator.pop(context);//[key,values[key]]);
                switch (widget.intent) {
                  case 1:
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => P2PChatView(
                    //           chatId: "${User.phoneNumber}-${values[key]}",
                    //           senderId: User.userId,
                    //           recepientId: values[key],
                    //           senderPhoneNumber: User.phoneNumber,
                    //           recepientPhoneNumber: values[key],
                    //         ),
                    //   ),
                    // );
                    break;
                  case 3:
                    break;
                  default:
                  // Navigator.push(context,
                  // MaterialPageRoute(builder: (context) => ChatHistory()));
                }
              },
            ),
            new Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }


_saveAContact(String name,String phoneNumber)async{
  Contact contact = new Contact(name: name,phoneNumber: phoneNumber);
Database d= await AllyDatabase().db;

ContactDB().addContact(contact, d);


}
  _saveABlockedContactAndOpenBlockedList(String name,String phoneNumber){
//save contact to databse
_saveAContact(name, phoneNumber);
//open blocked Contact list item
 MaterialPageRoute(builder: (context) => BlockedUsersList());
  }

  Widget _showAppropriatewidget() {
//    if(_Contact.length > 0){
    return Container(
        child: FutureBuilder<Map<dynamic, dynamic>>(
      future: _getContact(), //_calculateDistance( model,  store),
      initialData: {"kamau": "kenn"}, //0.0,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return createListView(context, snapshot);
        } else if (snapshot.hasError) {
          return Text("errror ${snapshot.error}");
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text("Contact"),
            ),
            body: _showAppropriatewidget()));
  }
}
