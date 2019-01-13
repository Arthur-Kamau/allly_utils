
import 'package:flutter/material.dart';

class Applicence extends StatefulWidget {
  static String tag = 'app-licence-page';
  _ApplicenceState createState() => _ApplicenceState();
}

class _ApplicenceState extends State<Applicence> {
 
 Widget _appbar(){
   return AppBar(
     backgroundColor: Colors.blue,
     title: Text("Ally Licence"),
   );
 }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar() ,
          body: Center( child:  Text("licence"),),
    );
  }
}