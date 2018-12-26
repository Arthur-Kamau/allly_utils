import 'package:flutter/material.dart';
import 'package:register/database/auth_data.dart';

import 'package:register/pages/login_register/login.dart';
import 'package:register/pages/login_register/register.dart';

import 'package:register/pages/login_register/register_extra_info.dart';
import 'package:register/pages/login_register/code_confirmation.dart';
import 'package:register/utils/app_id.dart';
import 'package:register/utils/random.dart';
import 'package:register/pages/licence/licence.dart';
import 'package:register/pages/slides/homePage.dart';
import 'package:register/pages/loading/loading.dart';
import 'package:register/pages/logout/logout.dart';
import 'package:register/pages/chat/chat_history.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(AllyHomePage());
}

class AllyHomePage extends StatefulWidget {
  @override
  AllyHomePageState createState() {
    return new AllyHomePageState();
  }
}

class AllyHomePageState extends State<AllyHomePage> {
  final routes = <String, WidgetBuilder>{
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
              child: CircularProgressIndicator(),
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
      routes: routes,
    );
  }
}
