

import 'package:ally_chat/pages/group/group_profile.dart';
import 'package:ally_chat/pages/group/groups_chat_view.dart';
import 'package:ally_chat/pages/person/person_chat_view.dart';
import 'package:ally_chat/pages/person/person_profile.dart';
import 'package:flutter/material.dart';
import 'package:ally_chat/pages/chat/chat_history.dart';
import 'package:ally_chat/pages/contacts/contacts_select_one.dart';


void main() {
  runApp(AllyHomePage());
}

class AllyHomePage extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    //setup page

    //ChatHistory
    ChatHistory.tag: (context) => ChatHistory(),

    ContactsSelectOne.tag: (context) => ContactsSelectOne(),
    GroupsDetails.tag: (context) => GroupsDetails(),

    P2GChatView.tag: (context) => P2GChatView(),

    P2PChatView.tag: (context) => P2PChatView(),

    UserPublicProfilePage.tag: (context) => UserPublicProfilePage(),
    
 
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ally App",

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF3D4878),
        scaffoldBackgroundColor: Colors.grey.shade200,
      ),
      home: ChatHistory(), //UserPrivateProfilePage(),
      //AllyLicencePage(),
      routes: routes,
    );
  }
}
