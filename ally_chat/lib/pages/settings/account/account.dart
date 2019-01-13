import 'dart:io';
import 'package:ally_chat/model/operations_models/contact_model.dart';
import 'package:ally_chat/pages/Interests/Interest_select_many.dart';
import 'package:ally_chat/pages/Interests/Interest_select_one.dart';
import 'package:ally_chat/pages/attach_items/pictures_screen.dart';
import 'package:ally_chat/pages/settings/account/change_email.dart';
import 'package:ally_chat/pages/settings/account/change_location.dart';
import 'package:ally_chat/pages/settings/account/change_name.dart';
import 'package:ally_chat/pages/settings/account/change_number.dart';
import 'package:ally_chat/pages/settings/account/change_status.dart';
import 'package:ally_chat/pages/settings/account/change_what_i_do.dart';
import 'package:ally_chat/pages/transition/slide_right_transition.dart';
import 'package:flutter/material.dart';

class UserAccount extends StatefulWidget {
  static String tag = 'user-account-page';
  @override
  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  String _myGender = "Other";
  String _myStatus = "status";
  String _myName = "name";
  String _myLocation = "location";
  String _doStatus = "doing status";
  String _myphoneNumber = "07...";
  String _myEmail = "me@mail.com";
  List<String> _myInterests = ["Social"];

  List<Widget> _createChildren() {
    List<Widget> _widgetItems = [];
    if (_myInterests != null) {
      for (String item in _myInterests) {
        print("$item");
        _widgetItems.add(GestureDetector(
          onTap: () => print('tapped'),
          child: Chip(
            // avatar: CircleAvatar(
            //   backgroundColor: Colors.blue, // Colors.grey.shade800,
            //   child: Text('AB'),
            // ),
            label: Text('$item'),
            deleteButtonTooltipMessage: 'Remove',
            onDeleted: () {
              print('removed');
              setState(() {
                _myInterests.remove(item);
              });
            },
          ),
        ));
      }

      return _widgetItems;
    }
  }

  Widget _userdetails() {
    return Container(
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                // We'll create the SelectionScreen in the next step!
                MaterialPageRoute(builder: (context) => AccountChangeName()),
              );
              if (_myName != null && _myName.toString().isNotEmpty) {
                setState(() {
                  _myName = result;
                });
              }
            },
            child: new ListTile(
              title: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text("Name",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                  Icon(
                    Icons.edit,
                    color: Colors.blue,
                  )
                ],
              ),
              subtitle: new Container(
                padding: const EdgeInsets.only(top: 2.0),
                child: new Text(_myName,
                    style: new TextStyle(color: Colors.black, fontSize: 12.0)),
              ),
            ),
          ),
          _divider(),
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                // We'll create the SelectionScreen in the next step!
                MaterialPageRoute(builder: (context) => AccountChangeStatus()),
              );
              if (_myStatus != null && _myStatus.toString().isNotEmpty) {
                setState(() {
                  _myStatus = result;
                });
              }
            },
            child: new ListTile(
              title: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text("Status",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                  Icon(
                    Icons.edit,
                    color: Colors.blue,
                  )
                ],
              ),
              subtitle: new Container(
                padding: const EdgeInsets.only(top: 2.0),
                child: new Text(_myStatus,
                    style: new TextStyle(color: Colors.black, fontSize: 12.0)),
              ),
            ),
          ),
          _divider(),
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                // We'll create the SelectionScreen in the next step!
                MaterialPageRoute(
                    builder: (context) => AccountChangeLocation()),
              );
              if (_myLocation != null && _myLocation.toString().isNotEmpty) {
                setState(() {
                  _myLocation = result;
                });
              }
            },
            child: new ListTile(
              title: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text("Location",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                  Icon(
                    Icons.edit,
                    color: Colors.blue,
                  )
                ],
              ),
              subtitle: new Container(
                padding: const EdgeInsets.only(top: 2.0),
                child: new Text(_myLocation,
                    style: new TextStyle(color: Colors.black, fontSize: 12.0)),
              ),
            ),
          ),
          _divider(),
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                // We'll create the SelectionScreen in the next step!
                MaterialPageRoute(builder: (context) => AccountChangeWhatIDo()),
              );
              if (_doStatus != null && _doStatus.toString().isNotEmpty) {
                setState(() {
                  _doStatus = result;
                });
              }
            },
            child: new ListTile(
              title: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text("What i do",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                  Icon(
                    Icons.edit,
                    color: Colors.blue,
                  )
                ],
              ),
              subtitle: new Container(
                padding: const EdgeInsets.only(top: 2.0),
                child: new Text(_doStatus,
                    style: new TextStyle(color: Colors.black, fontSize: 12.0)),
              ),
            ),
          ),
          _divider(),
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                // We'll create the SelectionScreen in the next step!
                MaterialPageRoute(builder: (context) => AccountChangeNumber()),
              );

              if (result != null && result.toString().isNotEmpty) {
                setState(() {
                  _myphoneNumber = result;
                });
              }
            },
            child: new ListTile(
              title: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text("Phone number",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                  Icon(
                    Icons.edit,
                    color: Colors.blue,
                  )
                ],
              ),
              subtitle: new Container(
                padding: const EdgeInsets.only(top: 2.0),
                child: new Text(_myphoneNumber,
                    style: new TextStyle(color: Colors.black, fontSize: 12.0)),
              ),
            ),
          ),
          _divider(),
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                // We'll create the SelectionScreen in the next step!
                MaterialPageRoute(builder: (context) => AccountChangeEmail()),
              );
              if (result != null && result.toString().isNotEmpty) {
                setState(() {
                  _myEmail = result;
                });
              }
            },
            child: new ListTile(
              title: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text("Email",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                  Icon(
                    Icons.edit,
                    color: Colors.blue,
                  )
                ],
              ),
              subtitle: new Container(
                padding: const EdgeInsets.only(top: 2.0),
                child: new Text(_myEmail,
                    style: new TextStyle(color: Colors.black, fontSize: 12.0)),
              ),
            ),
          ),
          _divider(),
          GestureDetector(
            onTap: () async {
              String res = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      title: const Text('Gender Preferences'),
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(5.0),
                          padding: EdgeInsets.all(5.0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: 20.0,
                              ),
                              SimpleDialogOption(
                                onPressed: () {
                                  Navigator.pop(context, "Male");
                                },
                                child: Container(
                                    height: 30.0,
                                    child: Center(child: Text("Male"))),
                              ),
                              _divider(),
                              SimpleDialogOption(
                                onPressed: () {
                                  Navigator.pop(context, "Female");
                                },
                                child: Container(
                                    height: 30.0,
                                    child: Center(child: Text("Female"))),
                              ),
                              _divider(),
                              SimpleDialogOption(
                                onPressed: () {
                                  Navigator.pop(context, "Other");
                                },
                                child: Container(
                                    height: 30.0,
                                    child: Center(child: Text("Other"))),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  });

              print("result discover preference dialogue $res");
              if (_myGender != null && _myGender.toString().isNotEmpty) {
                setState(() {
                  _myGender = res;
                });
              }
            },
            child: new ListTile(
              title: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text("Gender",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                  Icon(
                    Icons.edit,
                    color: Colors.blue,
                  )
                ],
              ),
              subtitle: new Container(
                padding: const EdgeInsets.only(top: 2.0),
                child: new Text(_myGender,
                    style: new TextStyle(color: Colors.black, fontSize: 12.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 5.0,
    );
  }

  Widget _personalData() {
    return Container(
      //height: 500.0,
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      child: SizedBox(
        child: Column(children: <Widget>[
          _userdetails(),
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                // We'll create the SelectionScreen in the next step!
                MaterialPageRoute(builder: (context) => SelectInterestMany()),
              );
              if (_myInterests != null && _myInterests.toString().isNotEmpty) {
                setState(() {
                  _myInterests = result;
                });
              }
            },
            child: new ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Interest",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.edit,
                    color: Colors.blue,
                  )
                ],
              ),
            ),
          ),
          Container(
            child: new Wrap(
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 4.0, // gap between lines
              children: _createChildren(),
            ),
          ),
          SizedBox(
            height: 50.0,
          )
        ]),
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
                Icon(
                  Icons.account_box,
                  color: Colors.blue,
                ),
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

  File _image;

  Future getImage() async {
    //  var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      //   _image = image;
    });
  }

  Widget _defaultImage() {
    return Image.asset(
      "assets/images/kenn.jpg",
      //"https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget _userSelectImage() {
    return Image.file(
      _image,
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width,
    );
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
                backgroundColor: Colors.blue,
                expandedHeight: 250.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("Account",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200.0,
                      child: GestureDetector(
                        onDoubleTap: () {
                          getImage();
                          print("Double tap image");
                        },
                        child: Stack(
                          children: <Widget>[
                            _image == null
                                ? _defaultImage()
                                : _userSelectImage(),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                padding: EdgeInsets.all(4.0),
                                icon: Icon(
                                  Icons.camera_alt,
                                  size: 26.0,
                                  color: Colors.black87,
                                ),
                                onPressed: () {
                                  print("get image");
                                  getImage();
                                },
                              ),
                            )
                          ],
                        ),
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
