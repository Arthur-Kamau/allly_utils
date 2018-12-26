import 'package:flutter/material.dart';

class ChatHistory extends StatefulWidget {
  static String tag = 'chat-history-page';
  _ChatHistoryState createState() => _ChatHistoryState();
}

class _ChatHistoryState extends State<ChatHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("exit app"),
              onPressed: () {},
            ),
            RaisedButton(
              child: Text("logout"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
