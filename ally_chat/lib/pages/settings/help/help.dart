//launched in user browser
import 'package:flutter/material.dart';

class AppHelp extends StatefulWidget {
  static String tag = 'app-help-page';
  _AppHelpState createState() => _AppHelpState();
}

class _AppHelpState extends State<AppHelp> {
 
 Widget _appbar(){
   return AppBar(
     title: Text("Logout Policy"),
   );
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar() ,
          body: Center( child:  Text("archives"),),
    );
  }
}