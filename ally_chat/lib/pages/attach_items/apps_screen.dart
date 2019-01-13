import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

import 'package:path/path.dart' as path;

class AppsScreen extends StatefulWidget {
  @override
  AppsScreenState createState() {
    return new AppsScreenState();
  }
}

class AppsScreenState extends State<AppsScreen> {
  static const platform = const MethodChannel('com.araizen/modules/utils');

  Future<List<dynamic>> _getContacts() async {
    List<dynamic> _conts = [];

    try {
      //getImagePaths 
      //getAppsApk
      _conts = await platform.invokeMethod('getAppsApk') as List<dynamic>;
    } on PlatformException catch (e) {
      print("\n\n Failed to get ciontacts : '${e.message}'. \n\n");
    }
print("\n\n flutter apk $_conts ");
    return _conts;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<dynamic> values = snapshot.data;

    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            new ListTile(
              title: new Text(
                path.basenameWithoutExtension(
                  '${values[index]}',
                ),
                style: TextStyle(fontSize: 13.0),
              ),
            ),
            new Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }

  Widget _showAppropriatewidget() {
//    if(_contacts.length > 0){
    return Container(
        child: FutureBuilder<List<dynamic>>(
      future: _getContacts(), //_calculateDistance( model,  store),
      initialData: ["kamau"], //0.0,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return createListView(context, snapshot);
        } else if (snapshot.hasError) {
          return Text("errror ${snapshot.error}");
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return _showAppropriatewidget();
  }
}
