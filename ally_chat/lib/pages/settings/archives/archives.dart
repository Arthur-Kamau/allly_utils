
import 'package:flutter/material.dart';

class ArchivesPolicy extends StatefulWidget {
  static String tag = 'archives-page';
  _ArchivesPolicyState createState() => _ArchivesPolicyState();
}

class _ArchivesPolicyState extends State<ArchivesPolicy> {
 
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