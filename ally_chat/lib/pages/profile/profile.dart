import 'package:ally_chat/model/operations_models/contact_model.dart';
import 'package:ally_chat/pages/attach_items/pictures_screen.dart';
import 'package:ally_chat/pages/settings/account/change_email.dart';
import 'package:ally_chat/pages/transition/slide_right_transition.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  static String tag = 'user-account-page';
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  List<String> _importedcontacts = [];

  List<Widget> _crateInterstChilderenItems() {
    List<Widget> _widgetItems = [];
    if (_importedcontacts != null) {
      for (String item in _importedcontacts) {
        print("$item");
        _widgetItems.add(GestureDetector(
          onTap: () => print('tapped'),
          child: Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.grey.shade800,
              child: Text('AB'),
            ),
            label: Text('$item'),
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
    }
  }

  Widget _userDetails() {
    return Column(
      children: <Widget>[
        new ListTile(
          leading: Icon(
            Icons.account_box,
            color: Colors.blue,
            size: 26.0,
          ),
          title: Text(
            "kamau kenn",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("only visible to you and ally"),
        ),
        Divider(
          color: Colors.blue,
          indent: 16.0,
        ),
        new ListTile(
          leading: Icon(
            Icons.account_box,
            color: Colors.blue,
            size: 26.0,
          ),
          title: Text(
            "@ kenn101",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(" visible to all"),
        ),
        Divider(
          color: Colors.blue,
          indent: 16.0,
        ),
        new ListTile(
          leading: Icon(
            Icons.email,
            color: Colors.blue,
            size: 26.0,
          ),
          title: Text(
            "kamau@mail.com ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          //subtitle: Text(""),
        ),
        Divider(
          color: Colors.blue,
          indent: 16.0,
        ),
        new ListTile(
          leading: Icon(
            Icons.phone,
            color: Colors.blue,
            size: 26.0,
          ),
          title: Text(
            "0719993309382",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(" "),
        ),
        Divider(
          color: Colors.blue,
          indent: 16.0,
        ),
        new ListTile(
          leading: Icon(
            Icons.phone,
            color: Colors.blue,
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
          children: _crateInterstChilderenItems(),
        )
      ],
    );
  }

  Widget _userdetails() {
    return Container(
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      child: Column(
        children: <Widget>[
          new ListTile(
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("name",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
              ],
            ),
            subtitle: new Container(
              padding: const EdgeInsets.only(top: 2.0),
              child: new Text("kamau",
                  style: new TextStyle(color: Colors.black, fontSize: 12.0)),
            ),
          ),
          _divider(),
          new ListTile(
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("Location",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
              ],
            ),
            subtitle: new Container(
              padding: const EdgeInsets.only(top: 2.0),
              child: new Text("Githurai 45",
                  style: new TextStyle(color: Colors.black, fontSize: 12.0)),
            ),
          ),
          _divider(),
          new ListTile(
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("What i do",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
              ],
            ),
            subtitle: new Container(
              padding: const EdgeInsets.only(top: 2.0),
              child: new Text("lCeo @ Araizen tech",
                  style: new TextStyle(color: Colors.black, fontSize: 12.0)),
            ),
          ),
          _divider(),
          new ListTile(
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("Status",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
              ],
            ),
            subtitle: new Container(
              padding: const EdgeInsets.only(top: 2.0),
              child: new Text("Loving flutter",
                  style: new TextStyle(color: Colors.black, fontSize: 12.0)),
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
    return ListView(
          children: <Widget>[
        Container(
          height: 500.0,
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          child: SizedBox(
            child: Column(children: <Widget>[
              _userdetails(),
              new ListTile(
                leading: Icon(
                  Icons.favorite_border,
                  color: Colors.blue,
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
                children: _crateInterstChilderenItems(),
              )
            ]),
          ),
        ),
      ],
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
                expandedHeight: 200.0,
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
                      child: Stack(
                        children: <Widget>[
                          Image.asset(
                            "assets/images/kenn.jpg",
                            //"https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
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
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PicturesScreen()));
                              },
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
          body: _personalData(),
        ),
      ),
    );
  }
}
