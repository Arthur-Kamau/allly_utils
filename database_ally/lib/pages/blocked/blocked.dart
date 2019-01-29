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
  List<Contact> _contact_blocked = []; // new List<Contact>();
  List<Contact> _contact_blocked_priv = [];
  getBlockedContactFromDatabase() {
    AllyDatabase().db.then((con) {
      BlockedContactDB().getAllContactsBlocked(con).then((contacts) {
        for (var i = 0; i < contacts.length; i++) {
          print("\n\n\n --->contacts ${contacts[i].name} \n\n\n");
          _contact_blocked_priv.add(contacts[i]);
        }
      });
    }).then((empty) {
      setState(() {
        _contact_blocked = _contact_blocked_priv;
      });
    });
  }

  saveBlockedContactToDatabase() {}

  @override
  void initState() {
    super.initState();
    getBlockedContactFromDatabase();
  }

  @override
  @override
  void dispose() {
    //save to database

    super.dispose();
  }

  Widget _blockedContactList() {
    //return Text("length ${_contact_blocked.length}");
    return new ListView.builder(
      itemCount: _contact_blocked.length,
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
                    new Text(_contact_blocked[i].name,
                        style: new TextStyle(fontWeight: FontWeight.bold)),
                    IconButton(
                      onPressed: () {
                        List<Contact> new_contact_blocked = new List<Contact>();
                        _contact_blocked.removeAt(i);

                        AllyDatabase().db.then((con) {
                          BlockedContactDB()
                              .removeAContact(_contact_blocked[i], con);
                        });

                        _contact_blocked.forEach((item) {
                          new_contact_blocked.add(item);
                        });

                        setState(() {
                          _contact_blocked = new_contact_blocked;
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
            // Navigator.pushNamed(context, ContactSelectMany.tag);
            List<Contact> result = await Navigator.push(
              context,
              // We'll create the SelectionScreen in the next step!
              MaterialPageRoute(builder: (context) => ContactSelectMany(
                numbersSelected: ,
              )),
            );
            print("the res  yyyyyyyyyy" + result.length.toString());

            if (result != null && result.length > 0) {
              _contact_blocked = new List<Contact>();
              for (var i = 0; i < result.length; i++) {
                print(
                    "\n con select many phone ${result[i].phoneNumber} name ${result[i].name} \n");

                //   _contact_blocked.add(Contact(
                //       name: result[i].name,
                //       phoneNumber: result[i].phoneNumber));

                AllyDatabase().db.then((con) {
                  BlockedContactDB().addContact(result[i], con);
                });
              }
            }

// setState(() { });

            if (result != null && result.toString().isNotEmpty) {
              setState(() {
                // _contact_blocked.addAll(result);// = result;
                _contact_blocked = result;
              });
            }
          },
        )
      ],
    );
  }

  Widget _showAppropriateWidget() {
    if (_contact_blocked != null) {
      if (_contact_blocked.length > 0) {
        //show Contact blocked list
        return _blockedContactList();
      } else {
        return Center(
          child: Text("No Contact blocked."),
        );
      }
    } else {
      //no Contact blcoed
      return Center(
        child: Text("No Contact blocked"),
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
