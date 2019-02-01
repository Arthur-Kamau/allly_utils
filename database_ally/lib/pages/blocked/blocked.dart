import 'package:database_ally/core/contact.dart';
import 'package:database_ally/database/blocked_contacts.dart';
import 'package:database_ally/database/database.dart';
import 'package:database_ally/pages/contacts/contacts_select_many.dart';
import 'package:flutter/material.dart';

class BlockedUsersList extends StatefulWidget {
  static String tag = 'user-settings-blockedusers-page';
  _BlockedUsersListState createState() => _BlockedUsersListState();
}

class _BlockedUsersListState extends State<BlockedUsersList> {
  // List<Contact> _contact_blocked = []; // new List<Contact>();
  // List<Contact> _contact_blocked_priv = [];
  // List<String> numbersSelectedFromDatabase = [];

  Future<List<Contact>> getBlockedContactFromDatabase() async {
    var conn = await AllyDatabase().db;
    var contacts = BlockedContactDB().getAllContactsBlocked(conn);

    return contacts;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //save to database
    super.dispose();
  }

  Widget _blockedContactList(List<Contact> _contactBlocked) {
    if (_contactBlocked != null && _contactBlocked.length > 0) {
      return new ListView.builder(
        itemCount: _contactBlocked.length,
        itemBuilder: (context, i) => new Column(
              children: <Widget>[
                new ListTile(
                  onTap: () {
                    print("Show group chat view");
                  },
                  onLongPress: () {
                    print("show contex menu");
                  },
                  title: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(_contactBlocked[i].name,
                          style: new TextStyle(fontWeight: FontWeight.bold)),
                      IconButton(
                        onPressed: () {
//remove from database
                          AllyDatabase().db.then((con) {
                            BlockedContactDB()
                                .removeAContact(_contactBlocked[i], con);
                          });

//show in view
                          setState(() {});
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
    } else {
      //no blocked contacts
      return Center(
        child: Text("No Contact blocked."),
      );
    }
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
            // Navigator.pushNamed(context, ContactSelectMany.tag);
            var cons = await AllyDatabase().db;
            List<String> blockedNumbers = await BlockedContactDB()
                .getAllContactsBlockedPhoneNumbers(cons);

            List<Contact> result = await Navigator.push(
              context,
              // We'll create the SelectionScreen in the next step!
              MaterialPageRoute(
                  builder: (context) =>
                      ContactSelectMany(numbersSelected: blockedNumbers)),
            );

            if (result != null && result.length > 0) {
              for (var i = 0; i < result.length; i++) {
                print(
                    "\n con select many phone ${result[i].phoneNumber} name ${result[i].name} \n");

                AllyDatabase().db.then((con) {
                  BlockedContactDB().addContact(result[i], con);
                });
              }
            }
          },
        )
      ],
    );
  }

  Widget _showAppropriateWidget() {
    return new FutureBuilder(
        future: getBlockedContactFromDatabase(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return _blockedContactList(snapshot.data);
          } else if (snapshot.error) {
            return Center(
              child: Text("No Contact blocked"),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _showAppropriateWidget(),
    );
  }
}
