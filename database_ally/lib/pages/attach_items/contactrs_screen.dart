import 'package:database_ally/core/intent.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class ContactsScreen extends StatefulWidget {
    static String tag = 'contacts-screen-page';
   int intent;

  String chatId;
  String senderId;
  String senderPhoneNumber;
  String recepientId;
  String recepientPhoneNumber;

  String groupId;
  String groupName;

  ContactsScreen(
      { this.intent = Intent.intentZeroAction,
       this.chatId = "",
       this.senderId = "",
       this.senderPhoneNumber = "",
       this.recepientId = "",
       this.recepientPhoneNumber= "",
       this.groupId = "",
       this.groupName =  ""});

  @override
  ContactsScreenState createState() {
    return new ContactsScreenState();
  }
}

class ContactsScreenState extends State<ContactsScreen> {
  static const platform = const MethodChannel('com.araizen/modules/utils');

  Future<Map<dynamic, dynamic>> _getContacts() async {
    Map<dynamic, dynamic> _conts = {};

    try {
      _conts =
          await platform.invokeMethod('getContacts') as Map<dynamic, dynamic>;
    } on PlatformException catch (e) {
      print("\n\n Failed to get ciontacts : '${e.message}'. \n\n");
    }

    return _conts;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    Map<dynamic, dynamic> values = snapshot.data;
if(values!=null && values.length >0 ){
    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        String key = values.keys.elementAt(index);
        return new Column(
          children: <Widget>[
            new ListTile(
              title: new Text("$key"),
              subtitle: new Text("${values[key]}"),
              onTap: (){
                  
              },
            ),
            new Divider(
              height: 2.0,
            ),
          ],
        );
      },
    ); }else{
  return Center(child: Text("No Contacts Available"),);
}

  }

  Widget _showAppropriatewidget() {
//    if(_contacts.length > 0){
    return Container(
        child: FutureBuilder<Map<dynamic, dynamic>>(
      future: _getContacts(), //_calculateDistance( model,  store),
      initialData: {"kamau": "kenn"}, //0.0,
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
