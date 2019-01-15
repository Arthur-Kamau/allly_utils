import 'package:ally_chat/core/contact.dart';
import 'package:ally_chat/core/user.dart';
import 'package:ally_chat/pages/person/person_chat_view.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class ContactsSelectMany extends StatefulWidget {
  static String tag = 'contacts-select-one-page';
  @override
  ContactsSelectManyState createState() {
    return new ContactsSelectManyState();
  }
}

class ContactsSelectManyState extends State<ContactsSelectMany> {
  static const platform = const MethodChannel('com.araizen/modules/utils');

  List<Contact> contacts_selected = new List<Contact>();
  List<String> number_Selected = [];

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

  bool _numberSelected(String numberSelected) {
    if (number_Selected != null &&
        number_Selected.length > 0 &&
        number_Selected.contains(numberSelected)) {
      return true;
    } else {
      return false;
    }
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    Map<dynamic, dynamic> values = snapshot.data;

    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        String key = values.keys.elementAt(index);
        return new Column(
          children: <Widget>[
            new ListTile(
              title: Row(children: <Widget>[
                Checkbox(
                  value: _numberSelected(values[key].toString()),
                  onChanged: (newVal) {
                    print("change $newVal");
                    setState(() {
                      if (newVal) {
                        number_Selected.add(values[key].toString());
                        contacts_selected.add(Contact(
                            name: key.toString(),
                            phoneNumber: values[key].toString()));
                      } else {
                        number_Selected.remove(values[key].toString());
                        contacts_selected.remove(Contact(
                            name: key.toString(),
                            phoneNumber: values[key].toString()));
                      }
                    });
                  },
                ),
                Flexible(
                  child: Container(
                    child: Text("$key"),
                    padding: EdgeInsets.only(left: 5.0),
                  ),
                ),
              ]),
              subtitle: Container(
                child: Text("${values[key]}"),
                padding: EdgeInsets.only(left: 35.0),
              ),
              onTap: () {
                print("tap contact");
              },
            ),
            Divider(
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
        child: FutureBuilder<Map<dynamic, dynamic>>(
      future: _getContacts(), //_calculateDistance( model,  store),
      initialData: {"data": "user"}, //0.0,
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  print("yyyyyyyyyy"+contacts_selected.length.toString());
                  Navigator.pop(context, contacts_selected);
                },
              ),
              title: Text("Contacts"),
            ),
            body: _showAppropriatewidget()));
  }
}
