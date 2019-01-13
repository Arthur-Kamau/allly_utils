import 'package:ally_chat/model/operations_models/contact_model.dart';
import 'package:flutter/material.dart';

class GroupsDetails extends StatefulWidget {
  static String tag = 'Group-Public-Profile-To-Users-page';
  String groupId;

  GroupsDetails({this.groupId});

  _GroupsDetailsState createState() => _GroupsDetailsState();
}

class _GroupsDetailsState extends State<GroupsDetails> {
  List<ContactsModel> _importedcontacts = dummyContacts;

  List<Widget> _createChildren() {
    List<Widget> _widgetItems = [];
    if (_importedcontacts != null) {
      for (ContactsModel item in _importedcontacts) {
        print("${item.mssidn}");
        _widgetItems.add(GestureDetector(
          onTap: () => print('tapped'),
          child: Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.grey.shade800,
              child: Text('AB'),
            ),
            label: Text('${item.name}'),
            //deleteButtonTooltipMessage: 'Remove',
            // onDeleted: () {
            //   print('removed');
            //   setState(() {
            //     _importedcontacts.remove(item);
            //   });
            // },
          ),
        ));
      }

      return _widgetItems;
    } else {
      return null;
    }
  }

  Widget _personalData() {
    return Container(
      height: 500.0,
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      child: SizedBox(
        child: Column(
          children: <Widget>[
            new ListTile(
              leading: Icon(
                Icons.account_box,
                // color: Colors.blue,
                size: 26.0,
              ),
              title: Text(
                "Type : Private Group ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              // color: Colors.blue,
              indent: 16.0,
            ),
            new ListTile(
              leading: Icon(
                Icons.account_box,
                // color: Colors.blue,
                size: 26.0,
              ),
              title: Text(
                "Name : Ally Syper team ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              // color: Colors.blue,
              indent: 16.0,
            ),
            new ListTile(
              leading: Icon(
                Icons.account_box,
                // color: Colors.blue,
                size: 26.0,
              ),
              title: Text(
                "Members : 24",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              // color: Colors.blue,
              indent: 16.0,
            ),
            new ListTile(
              leading: Icon(
                Icons.email,
                // color: Colors.blue,
                size: 26.0,
              ),
              title: Text(
                "Admin :  @carygi ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              //subtitle: Text(""),
            ),
            Divider(
              // color: Colors.blue,
              indent: 16.0,
            ),
            new ListTile(
              leading: Icon(
                Icons.phone,
                // color: Colors.blue,
                size: 26.0,
              ),
              title: Text(
                "Interest",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            new Wrap(
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 4.0, // gap between lines
              children: _createChildren(),
            )
          ],
        ),
      ),
    );
  }

  Widget _userData() {
    return Container(
      alignment: Alignment.center,
      width: 300.0,
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Card(
            elevation: 2.0,
            child: Row(
              children: <Widget>[
                Icon(Icons.account_box),
                Text("kamau"),
                IconButton(
                  icon: Icon(Icons.create),
                  onPressed: () {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _menuVert(BuildContext context) {
    return PopupMenuButton(
        onSelected: (choice) {
          if (choice == PopMenuDetails.joinGroup) {
            print("Join group");
          }
        },
        icon: Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        itemBuilder: (BuildContext context) {
          return PopMenuDetails.choices.map((String choice) {
            return PopupMenuItem(
              value: choice,
              child: Text(choice),
            );
          }).toList();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                // backgroundColor: Colors.blue,
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                actions: <Widget>[
                  _menuVert(context),
                ],
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200.0,
                      child: Stack(
                        children: <Widget>[
                          Image.asset(
                            "assets/images/birds.jpg",
                            //"https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height: 250.0,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              padding: EdgeInsets.all(4.0),
                              icon: Icon(
                                Icons.camera_alt,
                                size: 26.0,
                                color: Colors.black87,
                              ),
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                    )),
              ),
              // SliverPersistentHeader(
              //   delegate: _SliverAppBarDelegate(
              //     TabBar(
              //       labelColor: Colors.black87,
              //       unselectedLabelColor: Colors.grey,
              //       tabs: [
              //         Tab(icon: Icon(Icons.info), text: "Tab 1"),
              //         Tab(icon: Icon(Icons.lightbulb_outline), text: "Tab 2"),
              //       ],
              //     ),
              //   ),
              //   pinned: true,
              // ),
            ];
          },
          body: SingleChildScrollView(child: _personalData() // _userData(),
              ),
        ),
      ),
    );
  }
}

class PopMenuDetails {
  static const String joinGroup = 'Exit Group ';

  static const List<String> choices = [joinGroup];
}
//   List<GroupInterestModel> _importedcontacts = dummyData;

//   List<Widget> _createChildren() {
//     List<Widget> _widgetItems = [];
//     if (_importedcontacts != null) {
//       for (GroupInterestModel item in _importedcontacts) {
//         print("${item.interestCategory}");
//         _widgetItems.add(GestureDetector(
//           onTap: () => print('tapped'),
//           child: Chip(
//             avatar: CircleAvatar(
//               backgroundColor: Colors.grey.shade800,
//               child: Text('${item.interestCategory[0]}'),
//             ),
//             label: Text('${item.interestName}'),
//             //deleteButtonTooltipMessage: 'Remove',
//             // onDeleted: () {
//             //   print('removed');
//             //   setState(() {
//             //     _importedcontacts.remove(item);
//             //   });
//             // },
//           ),
//         ));
//       }

//       return _widgetItems;
//     } else {
//       return null;
//     }
//   }

//   Widget _personalData() {
//     return Container(
//       height: 500.0,
//       margin: EdgeInsets.all(0.0),
//       //margin: EdgeInsets.only(left: 10.0, right: 10.0),
//       child: SizedBox(
//         child: Column(
//           children: <Widget>[
//             Card(
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: new ListTile(
//                   leading: Icon(
//                     Icons.account_box,
//                     color: Colors.blue,
//                     size: 26.0,
//                   ),
//                   title: Text(
//                     "Group Name",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//             Card(
//               child: new ListTile(
//                 leading: Icon(
//                   Icons.fingerprint,
//                   color: Colors.blue,
//                   size: 26.0,
//                 ),
//                 title: Text(
//                   "Status",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//             Card(
//                 child: Column(children: <Widget>[
//               new ListTile(
//                 leading: Icon(
//                   Icons.alternate_email,
//                   color: Colors.blue,
//                   size: 26.0,
//                 ),
//                 title: Text(
//                   "Interest",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: new Wrap(
//                   spacing: 8.0, // gap between adjacent chips
//                   runSpacing: 4.0, // gap between lines
//                   children: _createChildren(),
//                 ),
//               ),
//             ])),
//             Card(
//               child: new ListTile(
//                 title: Text(
//                   "Group Members",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _userData() {
//     return Container(
//       alignment: Alignment.center,
//       width: 300.0,
//       padding: EdgeInsets.all(10.0),
//       child: Column(
//         children: <Widget>[
//           Card(
//             elevation: 2.0,
//             child: Row(
//               children: <Widget>[
//                 Icon(Icons.supervisor_account),
//                 Text("kamau"),
//                 IconButton(
//                   icon: Icon(Icons.create),
//                   onPressed: () {},
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: DefaultTabController(
//         length: 2,
//         child: NestedScrollView(
//           headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//             return <Widget>[
//               SliverAppBar(
//                 backgroundColor: Colors.blue,
//                 expandedHeight: 200.0,
//                 floating: false,
//                 pinned: true,
//                 flexibleSpace: FlexibleSpaceBar(
//                     centerTitle: true,
//                     title: Text("",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16.0,
//                         )),
//                     background: Container(
//                       width: MediaQuery.of(context).size.width,
//                       height: 200.0,
//                       child: Stack(
//                         children: <Widget>[
//                           Image.asset(
//                             "assets/images/kenn.jpg",
//                             //"https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
//                             fit: BoxFit.cover,
//                             width: MediaQuery.of(context).size.width,
//                           ),
//                           Align(
//                             alignment: Alignment.bottomRight,
//                             child: IconButton(
//                               padding: EdgeInsets.all(4.0),
//                               icon: Icon(
//                                 Icons.camera_alt,
//                                 size: 26.0,
//                                 color: Colors.black54,
//                               ),
//                               onPressed: () {},
//                             ),
//                           )
//                         ],
//                       ),
//                     )),
//               ),
//               // SliverPersistentHeader(
//               //   delegate: _SliverAppBarDelegate(
//               //     TabBar(
//               //       labelColor: Colors.black87,
//               //       unselectedLabelColor: Colors.grey,
//               //       tabs: [
//               //         Tab(icon: Icon(Icons.info), text: "Tab 1"),
//               //         Tab(icon: Icon(Icons.lightbulb_outline), text: "Tab 2"),
//               //       ],
//               //     ),
//               //   ),
//               //   pinned: true,
//               // ),
//             ];
//           },
//           body: Center(child: _personalData() // _userData(),
//               ),
//         ),
//       ),
//     );
//   }
// }
