import 'package:flutter/material.dart';
import 'package:register/database/auth_data.dart';
import 'package:register/pages/logout/logout.dart';

class ChatHistory extends StatefulWidget {
  static String tag = 'chat-history-page';
  _ChatHistoryState createState() => _ChatHistoryState();
}

class _ChatHistoryState extends State<ChatHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 300.0,
          width: 300.0,
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text("exit app"),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return new LogoutSplashScreen();
                  }));
                },
              ),
              RaisedButton(
                child: Text("logout"),
                //delete database data
                //open logout page
                onPressed: () {
                  var dbHelper = AuthData();
                  dbHelper.deleteUserDetails();

                  var d = dbHelper.getAuthDetails();
                  d.then((data) {
                    print("data --> ${data.authTime}");
                  });
                  // Navigator.of(context).pushReplacement(
                  // new MaterialPageRoute(builder: (BuildContext context) {
                  // return new LogoutSplashScreen();
                  // }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
