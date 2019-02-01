import 'package:ally_chat/database/auth_data_db.dart';
import 'package:ally_chat/pages/attach_items/attach_items.dart';
import 'package:ally_chat/pages/contacts/contacts_select_many.dart';
import 'package:ally_chat/pages/group/group_profile.dart';
import 'package:ally_chat/pages/group/groups_chat_view.dart';
import 'package:ally_chat/pages/licence/licence.dart';
import 'package:ally_chat/pages/loading/loading.dart';
import 'package:ally_chat/pages/login_register/code_confirmation.dart';
import 'package:ally_chat/pages/login_register/login.dart';
import 'package:ally_chat/pages/login_register/register.dart';
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
import 'package:ally_chat/pages/slides/homePage.dart';
import 'package:ally_chat/utils/app_id.dart';
import 'package:flutter/material.dart';
import 'package:ally_chat/pages/chat/chat_history.dart';
import 'package:ally_chat/pages/contacts/contacts_select_one.dart';

void main() {
  runApp(AllyHomePage());
}

class AllyHomePage extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    //setup page
    //intor slider
    IntroSliderHomePage.tag: (context) => IntroSliderHomePage(),
//logout
    LogoutSplashScreen.tag: (context) => LogoutSplashScreen(),
    //login

    LogInPage.tag: (context) => LogInPage(),
//register
    RegisterPage.tag: (context) => RegisterPage(),
//register extra info
    IntroSliderHomePage.tag: (context) => IntroSliderHomePage(),
//licence page
    AllyLicencePage.tag: (context) => AllyLicencePage(),
//chat history
    ChatHistory.tag: (context) => ChatHistory(),
    //code confirmation
    ConfirmCode.tag: (context) => ConfirmCode(),

    //ChatHistory
    ChatHistory.tag: (context) => ChatHistory(),

    ContactsSelectMany.tag: (context) => ContactsSelectMany(),
    ContactsSelectOne.tag: (context) => ContactsSelectOne(),

    
    GroupsDetails.tag: (context) => GroupsDetails(),

    P2GChatView.tag: (context) => P2GChatView(),

    P2PChatView.tag: (context) => P2PChatView(),

    UserPublicProfilePage.tag: (context) => UserPublicProfilePage(),

    AttachItems.tag: (context) => AttachItems(),

      UserAccount.tag: (context) => UserAccount(),
    AccountChangeEmail.tag: (context) => AccountChangeEmail(),
    AccountChangeNumber.tag: (context) => AccountChangeNumber(),
    AccountChangeStatus.tag: (context) => AccountChangeStatus(),
    AccountChangeName.tag: (context) => AccountChangeName(),
    AccountChangeWhatIDo.tag: (context) => AccountChangeWhatIDo(),
    AccountChangeLocation.tag: (context) => AccountChangeLocation(),






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

  Future<AuthDetails> getAppToken() {
    AppId().stateAppId();

    Future<AuthDetails> auth = AuthData().getAuthDetails();
    return auth;
  }

    Widget dataChoice(BuildContext context, AsyncSnapshot<AuthDetails> snapshot) {
    print("\n\n\n\ We checking data choice ${snapshot.data.deviceId}\n");

    var val = snapshot.data;
    if (val == null) {
      //show licence page
      return AllyLicencePage();
    } else if (val != null) {
      if (val.authtoken.length > 0) {
        //user has token
        //show app main page
        return ChatHistory();
      } else {
        return AllyLicencePage();
      }
    }
  }

    Widget _showApropriateWidget() {
    return new FutureBuilder<AuthDetails>(
        future: getAppToken(),
        //    initialData: "Loading text..",
        builder: (BuildContext context, AsyncSnapshot<AuthDetails> data) {
          if (data.hasData) {
            return dataChoice(context, data);
          } else if (data.hasError) {
            return Text("errror ${data.error}");
          } else {
            return Center(
              child: ColorLoader(),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ally App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF3D4878),
        scaffoldBackgroundColor: Colors.grey.shade200,
      ),
       home: _showApropriateWidget(),
      //home: ChatHistory(),
      //AllyLicencePage(),
      routes: routes,
    );
  }
}
