import 'package:ally_chat/core/intent.dart';
import 'package:ally_chat/pages/group/groups_chat_view.dart';
import 'package:ally_chat/pages/person/person_chat_view.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

import 'package:path/path.dart' as path;

class VideoScreen extends StatefulWidget {
  int intent;

  String chatId;
  String senderId;
  String senderPhoneNumber;
  String recepientId;
  String recepientPhoneNumber;

  String groupId;
  String groupName;

  VideoScreen(
      {@required this.intent,
      @required this.chatId,
      @required this.senderId,
      @required this.senderPhoneNumber,
      @required this.recepientId,
      @required this.recepientPhoneNumber,
      @required this.groupId,
      @required this.groupName});

  @override
  VideoScreenState createState() {
    return new VideoScreenState();
  }
}

class VideoScreenState extends State<VideoScreen> {
  static const platform = const MethodChannel('com.araizen/modules/utils');

  Future<List<dynamic>> _getContacts() async {
    List<dynamic> _conts = [];

    try {
      _conts = await platform.invokeMethod('getAllVideoPaths') as List<dynamic>;
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
    List<dynamic> values = snapshot.data;

    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            new ListTile(
              title: new Text(
                path.basenameWithoutExtension(
                  '${values[index]}',
                ),
                style: TextStyle(fontSize: 13.0),
              ),
              onTap: () {
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
        child: FutureBuilder<List<dynamic>>(
      future: _getContacts(), //_calculateDistance( model,  store),
      initialData: ["kamau"], //0.0,
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
