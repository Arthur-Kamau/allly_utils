import 'package:flutter/material.dart';

class LogOutPolicy extends StatefulWidget {
  static String tag = 'log-out-policy-page';
  _LogOutPolicyState createState() => _LogOutPolicyState();
}

class _LogOutPolicyState extends State<LogOutPolicy> {
  Widget _appbar() {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text("Data Policy"),
    );
  }

  Widget _divider() {
    return Divider(
      height: 5.0,
    );
  }

  Widget _logoutSettings() {
    return Container(
      child: Column(
        children: <Widget>[
             SwitchListTile(
            title: Text("Encrypt data on logout"),
            subtitle: Text("Recommended"),
            value: true,
            onChanged: (option){

            },
          ),


          _divider(),
          SwitchListTile(
            title: Text("Delete data on logout"),
            subtitle: Text("Data expensive"),
            value: true,
            onChanged: (option){

            },
          ),
            _divider(),
          new ListTile(
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("Delete all local data",
                    style: new TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black)),
              ],
            ),
            subtitle: new Container(
              padding: const EdgeInsets.only(top: 2.0),
              child: new Text("Will empty cache & previous chats",
                  style: new TextStyle(color: Colors.black, fontSize: 12.0)),
            ),
          ),
          _divider(),
     
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: Center(
        child: _logoutSettings(),
      ),
    );
  }
}
