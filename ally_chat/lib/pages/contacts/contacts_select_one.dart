import 'package:ally_chat/core/user.dart';
import 'package:ally_chat/pages/chat/chat_history.dart';
import 'package:ally_chat/pages/person/person_chat_view.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

//intent one ->chat history
//        two ->chat item

class ContactsSelectOne extends StatefulWidget {
  static String tag = 'contacts-select-one-page';
  int intent;
  ContactsSelectOne({@required this.intent});

  @override
  ContactsSelectOneState createState() {
    return new ContactsSelectOneState();
  }
}

class ContactsSelectOneState extends State<ContactsSelectOne> {
  static const platform = const MethodChannel('com.araizen/modules/utils');

  Future<Map<dynamic, dynamic>> _getContacts() async {
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => P2PChatView(
                              chatId: "${User.phoneNumber}-${values[key]}",
                              senderId: User.userId,
                              recepientId: values[key],
                              senderPhoneNumber: User.phoneNumber,
                              recepientPhoneNumber: values[key],
                            ),
                      ),
                    );
                    break;
                  default:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChatHistory()));
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

  Widget _showAppropriatewidget() {
//    if(_contacts.length > 0){
    return Container(
        child: FutureBuilder<Map<dynamic, dynamic>>(
      future: _getContacts(), //_calculateDistance( model,  store),
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
              title: Text("Contacts"),
            ),
            body: _showAppropriatewidget()));
  }
}
