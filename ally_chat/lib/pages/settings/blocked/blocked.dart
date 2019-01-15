import 'package:ally_chat/core/contact.dart';
import 'package:ally_chat/pages/contacts/contacts_select_many.dart';
import 'package:ally_chat/pages/contacts/contacts_select_one.dart';
import 'package:flutter/material.dart';

import 'package:ally_chat/model/operations_models/chat_history_model.dart';

class BlockedUsersList extends StatefulWidget {
  static String tag = 'user-settings-blockedusers-page';
  _BlockedUsersListState createState() => _BlockedUsersListState();
}

class _BlockedUsersListState extends State<BlockedUsersList> {
  List<Contact> _contacts_blocked = [
    Contact(name: "kaaaaa", phoneNumber: "101919"),
    Contact(name: "kaaaaa", phoneNumber: "101919")
  ]; // new List<Contact>();

  Widget _blockedContactsList() {
    //return Text("length ${_contacts_blocked.length}");
    return new ListView.builder(
      itemCount: _contacts_blocked.length,
      itemBuilder: (context, i) => new Column(
            children: <Widget>[
              new ListTile(
                onTap: () {
                  print("Show group chat view");
                },
                onLongPress: () {
                  print("show contex menu");
                },
                // leading: new CircleAvatar(
                //     foregroundColor: Theme.of(context).primaryColor,
                //     backgroundColor: Colors.grey,
                //     backgroundImage: new AssetImage(dummyData[i].avatarUrl)),
                title: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(_contacts_blocked[i].name,
                        style: new TextStyle(fontWeight: FontWeight.bold)),
                    IconButton(
                      onPressed: () {
                        List<Contact> new_contacts_blocked =
                            new List<Contact>();
                        _contacts_blocked.removeAt(i);

                        _contacts_blocked.forEach((item) {
                          new_contacts_blocked.add(item);
                        });

                        setState(() {
                          _contacts_blocked = new_contacts_blocked;
                        });
                      },
                      icon: Icon(Icons.delete),
                    )
                  ],
                ),
              ),
              new Divider(
                height: 10.0,
              ),
            ],
          ),
    );
  }

  Widget _appbar() {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text("Blocked "),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () async {
            // Navigator.pushNamed(context, ContactsSelectMany.tag);
            List<Contact> result = await Navigator.push(
              context,
              // We'll create the SelectionScreen in the next step!
              MaterialPageRoute(builder: (context) => ContactsSelectMany()),
            );
            print("the res  yyyyyyyyyy" + result.length.toString());

            if (result != null && result.length > 0) {
              _contacts_blocked = new List<Contact>();
              for (var i = 0; i < result.length; i++) {
                print(
                    "\n con select many phone ${result[i].phoneNumber} name ${result[i].name} \n");

                //   _contacts_blocked.add(Contact(
                //       name: result[i].name,
                //       phoneNumber: result[i].phoneNumber));

              }
            }

// setState(() { });

            if (result != null && result.toString().isNotEmpty) {
              setState(() {
                // _contacts_blocked.addAll(result);// = result;
                _contacts_blocked = result;
              });
            }
          },
        )
      ],
    );
  }

  Widget _showAppropriateWidget() {
    if (_contacts_blocked != null) {
      if (_contacts_blocked.length > 0) {
        //show contacts blocked list
        return _blockedContactsList();
      } else {
        return Center(
          child: Text("No contacts blocked."),
        );
      }
    } else {
      //no contacts blcoed
      return Center(
        child: Text("No contacts blocked"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _showAppropriateWidget(),
    );
  }
}
