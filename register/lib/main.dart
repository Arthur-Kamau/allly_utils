import 'package:flutter/material.dart';

import 'package:register/pages/login_register/login.dart';
import 'package:register/pages/login_register/register.dart';

import 'package:register/pages/login_register/register_extra_info.dart';
import 'package:register/pages/login_register/code_confirmation.dart';

import 'package:register/pages/licence/licence.dart';
import 'package:register/pages/slides/homePage.dart';
import 'package:register/pages/loading/loading.dart';
import 'package:register/pages/logout/logout.dart';
import 'package:register/pages/chat/chat_history.dart';

void main() {
  runApp(AllyHomePage());
}

class AllyHomePage extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ally App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF3D4878),
        scaffoldBackgroundColor: Colors.grey.shade200,
      ),
      home: AllyLicencePage(),
      routes: routes,
    );
  }
}
