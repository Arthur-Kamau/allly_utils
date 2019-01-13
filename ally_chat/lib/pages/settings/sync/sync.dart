
import 'package:flutter/material.dart';

class SyncData extends StatefulWidget {
  static String tag = 'sync-data-page';
  _SyncDataState createState() => _SyncDataState();
}

class _SyncDataState extends State<SyncData> {
 
 Widget _appbar(){
   return AppBar(
     backgroundColor: Colors.blue,
     centerTitle: true,
     title: Text("Sync Data"),
   );
 }
  Widget _divider() {
    return Divider(
      height: 5.0,
    );
  }

  Widget _syncSetiings() {
    return Container(
      child: Column(
        children: <Widget>[
             
          new ListTile(
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("repopulate local data",
                    style: new TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black)),
              ],
            ),
            subtitle: new Container(
              padding: const EdgeInsets.only(top: 2.0),
              child: new Text("long and data expensive",
                  style: new TextStyle(color: Colors.black, fontSize: 12.0)),
            ),
          ),
          _divider(),
           new ListTile(
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("Check local data integrity",
                    style: new TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black)),
              ],
            ),
            subtitle: new Container(
              padding: const EdgeInsets.only(top: 2.0),
              child: new Text("fast but not comprehensive",
                  style: new TextStyle(color: Colors.black, fontSize: 12.0)),
            ),
          ),
          _divider(),
            new ListTile(
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("Sync Contacts",
                    style: new TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black)),
              ],
            ),
            subtitle: new Container(
              padding: const EdgeInsets.only(top: 2.0),
              child: new Text("checks contact adition/deletion",
                  style: new TextStyle(color: Colors.black, fontSize: 12.0)),
            ),
          ),
     
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar() ,
          body: _syncSetiings(),
    );
  }
}