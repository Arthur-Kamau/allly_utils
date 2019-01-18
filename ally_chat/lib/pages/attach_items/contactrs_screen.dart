import 'package:ally_chat/core/intent.dart';
import 'package:ally_chat/pages/group/groups_chat_view.dart';
import 'package:ally_chat/pages/person/person_chat_view.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class ContactsScreen extends StatefulWidget {
   int intent;

  String chatId;
  String senderId;
  String senderPhoneNumber;
  String recepientId;
  String recepientPhoneNumber;

  String groupId;
  String groupName;

  ContactsScreen(
      {@required this.intent,
      @required this.chatId,
      @required this.senderId,
      @required this.senderPhoneNumber,
      @required this.recepientId,
      @required this.recepientPhoneNumber,
      @required this.groupId,
      @required this.groupName});

  @override
  ContactsScreenState createState() {
    return new ContactsScreenState();
  }
}

class ContactsScreenState extends State<ContactsScreen> {
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
              onTap: (){
                  if (widget.intent == Intent.appsScreenChatIntent) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => P2PChatView(
                              chatId: widget.groupId,
                              senderId: widget.senderId,
                              recepientId: widget.recepientId,
                              senderPhoneNumber: widget.senderPhoneNumber,
                              recepientPhoneNumber: widget.recepientPhoneNumber,
                            ),
                      ));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => P2GChatView(
                              //  chatId: chatHistory.chatId,
                              groupId: widget.groupId,
                              groupName: widget.groupName,
                            ),
                      ));
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
    return _showAppropriatewidget();
  }
}
