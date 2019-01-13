import 'package:ally_chat/pages/contacts/contacts_select_one.dart';
import 'package:flutter/material.dart';

import 'package:ally_chat/model/operations_models/chat_history_model.dart';

class BlockedUsersList extends StatefulWidget {
   static String tag = 'user-settings-blockedusers-page';
  _BlockedUsersListState createState() => _BlockedUsersListState();
}

class _BlockedUsersListState extends State<BlockedUsersList> {
 



  //  final contacts = new ListView.builder(
  //   itemCount: dummyData.length,
  //   itemBuilder: (context, i) => new Column(
  //         children: <Widget>[
  //           new ListTile(
  //             onTap: () {
  //               print("Show group chat view");

  //             },
  //             onLongPress: () {
  //               print("show contex menu");
  //             },
  //             leading: new CircleAvatar(
  //                 foregroundColor: Theme.of(context).primaryColor,
  //                 backgroundColor: Colors.grey,
  //                 backgroundImage: new AssetImage(dummyData[i].avatarUrl)),
  //             title: new Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: <Widget>[
  //                 new Text(dummyData[i].name,
  //                     style: new TextStyle(fontWeight: FontWeight.bold)),
  //                IconButton(
  //                  onPressed: (){

  //                  },
  //                  icon: Icon(Icons.delete),
  //                )
  //               ],
  //             ),
             
  //           ),
  //           new Divider(
  //             height: 10.0,
  //           ),
  //         ],
  //       ),
  // );

 Widget _appbar(){
   return AppBar(
     backgroundColor: Colors.blue,
     centerTitle: true,
     title: Text("Blocked "),
     actions: <Widget>[
       IconButton(
         icon: Icon(Icons.add),
         onPressed: (){
            Navigator.pushNamed(context, ContactsSelectOne.tag);
         },
       )
     ],
   );
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
       body: Text("wrking")//contacts,
    );
  }
}