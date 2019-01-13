import 'package:ally_chat/pages/attach_items/attach_items.dart';
import 'package:ally_chat/pages/group/group_profile.dart';
import 'package:ally_chat/pages/group/groups_chat_view.dart';
import 'package:ally_chat/pages/person/person_chat_view.dart';
import 'package:ally_chat/pages/person/person_profile.dart';
import 'package:ally_chat/pages/profile/profile.dart';
import 'package:ally_chat/pages/settings/account/account.dart';
import 'package:ally_chat/pages/settings/account/change_email.dart';
import 'package:ally_chat/pages/settings/account/change_number.dart';
import 'package:ally_chat/pages/settings/app_information/app_information.dart';
import 'package:ally_chat/pages/settings/app_information/app_information_deails.dart';
import 'package:ally_chat/pages/settings/app_information/app_information_developers.dart';
import 'package:ally_chat/pages/settings/archives/archives.dart';
import 'package:ally_chat/pages/settings/blocked/blocked.dart';
import 'package:ally_chat/pages/settings/logout_policy/logout_policy.dart';
import 'package:ally_chat/pages/settings/logout_policy/logout_splash_screen.dart';
import 'package:ally_chat/pages/settings/sync/sync.dart';
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

    AttachItems.tag: (context) => AttachItems(),

    UserAccount.tag: (context) => UserAccount(),
    AccountChangeEmail.tag: (context) => AccountChangeEmail(),
    AccountChangeNumber.tag: (context) => AccountChangeNumber(),

    AppInformtaionDetails.tag: (context) => AppInformtaionDetails(),
    AppInformationDevelopers.tag: (context) => AppInformationDevelopers(),
    AppInformationPolicy.tag: (context) => AppInformationPolicy(),
    ArchivesPolicy.tag: (context) => ArchivesPolicy(),
    BlockedUsersList.tag: (context) => BlockedUsersList(),

    LogOutPolicy.tag: (context) => LogOutPolicy(),
    LogoutSplashScreen.tag: (context) => LogoutSplashScreen(),
    SyncData.tag: (context) => SyncData(),
     UserProfile.tag: (context) => UserProfile(),
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
      home: ChatHistory(),
      //AllyLicencePage(),
      routes: routes,
    );
  }
}
