
import 'package:flutter/material.dart';

class HistoryPolicy extends StatefulWidget {
  static String tag = 'log-out-policy-page';
  _HistoryPolicyState createState() => _HistoryPolicyState();
}

class _HistoryPolicyState extends State<HistoryPolicy> {
 
 Widget _appbar(){
   return AppBar(
     title: Text("User History"),
   );
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar() ,
          body: Center( child:  Text("History"),),
    );
  }
}