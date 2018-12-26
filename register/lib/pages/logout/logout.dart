import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

class LogoutSplashScreen extends StatefulWidget {
  static String tag = 'log-out-splash-page';
  _LogoutSplashScreenState createState() => _LogoutSplashScreenState();
}

class _LogoutSplashScreenState extends State<LogoutSplashScreen> {

@override
void initState() {
  super.initState();
  startTime();
}

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    print("nav done");
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
        height:  MediaQuery.of(context).size.height ,
        width:  MediaQuery.of(context).size.width ,
        color: Colors.blue,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/icons/Ally_icon_Blue.png",height: 100.0,width: 100.0,),
            SizedBox(height: 20.0,),
            Text("Logging you out",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white
              ),
            )
          ],
        ),
      ),
    );
  }
}