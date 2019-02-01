import 'dart:io';
import 'package:database_ally/core/profile.dart';
import 'package:database_ally/database/account.dart';
import 'package:database_ally/database/database.dart';
import 'package:database_ally/model/operations_models/contact_model.dart';
import 'package:database_ally/pages/Interests/Interest_select_many.dart';
import 'package:database_ally/pages/Interests/Interest_select_one.dart';
import 'package:database_ally/pages/attach_items/pictures_screen.dart';
import 'package:database_ally/pages/account/change_email.dart';
import 'package:database_ally/pages/account/change_location.dart';
import 'package:database_ally/pages/account/change_name.dart';
import 'package:database_ally/pages/account/change_number.dart';
import 'package:database_ally/pages/account/change_status.dart';
import 'package:database_ally/pages/account/change_what_i_do.dart';
import 'package:database_ally/pages/transition/slide_right_transition.dart';
import 'package:flutter/material.dart';

class UserAccount extends StatefulWidget {
  static String tag = 'user-account-page';
  @override
  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  AccountProfile profileData;
  @override
  void initState() {
    getUserAccountProfileData();
    super.initState();
  }

  void getUserAccountProfileData() async {
    var conn = await AllyDatabase().db;
    profileData = await UserAccountProfile().getUserAccountProfile(conn);
  }

  List<Widget> _createChildren(List<String> myInterest) {
    List<Widget> _widgetItems = [];
    if (myInterest != null && myInterest.isNotEmpty) {
      for (String item in myInterest) {
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
                myInterest.remove(item);
              });
            },
          ),
        ));
      }

      return _widgetItems;
    }
  }

  Widget _userDetailEmail(String email) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          // We'll create the SelectionScreen in the next step!
          MaterialPageRoute(builder: (context) => AccountChangeEmail()),
        );
        if (result != null && result.toString().isNotEmpty) {
          setState(() {});
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
          child: new Text(email,
              style: new TextStyle(color: Colors.black, fontSize: 12.0)),
        ),
      ),
    );
  }

  Widget _userDetailGender(String gender) {
    return GestureDetector(
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
                              height: 30.0, child: Center(child: Text("Male"))),
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
        if (res != null && res.toString().isNotEmpty) {
          setState(() {});
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
          child: new Text(gender,
              style: new TextStyle(color: Colors.black, fontSize: 12.0)),
        ),
      ),
    );
  }

  Widget _userDetailWhatIDo(String doStatus) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          // We'll create the SelectionScreen in the next step!
          MaterialPageRoute(builder: (context) => AccountChangeWhatIDo()),
        );
        if (result != null && result.toString().isNotEmpty) {
          setState(() {
            //  _doStatus = result;
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
          child: new Text(doStatus,
              style: new TextStyle(color: Colors.black, fontSize: 12.0)),
        ),
      ),
    );
  }

  Widget _userDetailLocation(String location) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          // We'll create the SelectionScreen in the next step!
          MaterialPageRoute(builder: (context) => AccountChangeLocation()),
        );
        if (result != null && result.toString().isNotEmpty) {
          setState(() {
            //_myLocation = result;
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
          child: new Text(location,
              style: new TextStyle(color: Colors.black, fontSize: 12.0)),
        ),
      ),
    );
  }

  Widget _userDetailStatus(String status) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          // We'll create the SelectionScreen in the next step!
          MaterialPageRoute(builder: (context) => AccountChangeStatus()),
        );
        if (result != null && result.toString().isNotEmpty) {
          setState(() {
            //  _myStatus = result;
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
          child: new Text(status,
              style: new TextStyle(color: Colors.black, fontSize: 12.0)),
        ),
      ),
    );
  }

  Widget _userDetailName(String name) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          // We'll create the SelectionScreen in the next step!
          MaterialPageRoute(builder: (context) => AccountChangeName()),
        );
        if (result != null && result.toString().isNotEmpty) {
          setState(() {
            //_myName = result;
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
          child: new Text(name,
              style: new TextStyle(color: Colors.black, fontSize: 12.0)),
        ),
      ),
    );
  }

  Widget _userdetails(AccountProfile profileData) {
     String userName ;
    String userStatus ;
    String userLocation ;
    String userWhatIDo ;
    String userGender ;


    if(profileData !=null){
  userName = profileData.name == null ? "Name" : profileData.name;
      userStatus = profileData.status == null ? "Am loving ally" : profileData.status;
      userLocation = profileData.location == null ? "Unknown" : profileData.location;
      userWhatIDo = profileData.whatIDO == null ? "Unknown" : profileData.whatIDO;
      userGender = profileData.gender == null ? "Unknown" : profileData.gender;
    }else{
  userName = "Name" ;
      userStatus = "Am loving ally" ;
      userLocation = "Unknown";
      userWhatIDo = "Unknown" ;
      userGender ="Unknown" ;
    }
   
    return Container(
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      child: Column(
        children: <Widget>[
          _userDetailName(userName),
          _divider(),
          _userDetailStatus(userStatus),
          _divider(),
          _userDetailLocation(userLocation),
          _divider(),
          _userDetailWhatIDo(userWhatIDo),
          _divider(),
          // _userDetailPhoneNumber(),
          // _divider(),
          // _userDetailEmail(),
          // _divider(),
          _userDetailGender(userGender),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 5.0,
    );
  }

  Widget _personalData(AccountProfile profileData) {
    // List<String> myInterest = profileData.interest.split(",");
    // print("\n\n\n\n --------------$myInterest----------\n\n\n");
    return Container(
      //height: 500.0,
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      child: SizedBox(
        child: Column(children: <Widget>[
          _userdetails(profileData),
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                // We'll create the SelectionScreen in the next step!
                MaterialPageRoute(builder: (context) => SelectInterestMany()),
              );

              // if (myInterest != null && myInterest.toString().isNotEmpty) {
              //   setState(() {
              //     //_myInterests = result;
              //   });
              // }
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
              // children: _createChildren(myInterest),
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

  String _imagePath;

  Widget _defaultImage() {
    return Image.asset(
      "assets/images/kenn.jpg",
      //"https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget _userSelectImage() {
    _image = new File(_imagePath);
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
                          print("Double tap image");
                        },
                        child: Stack(
                          children: <Widget>[
                            _imagePath == null || _imagePath.isEmpty
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
                                onPressed: () async {
                                  print("get image");

                                  var res = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PicturesScreen(),
                                    ),
                                  );

                                  print("\n\n $res == get image \n\n");
                                  setState(() {
                                    _imagePath = res;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: _personalData(profileData),
            // child: new FutureBuilder(
            //     future: userAccountProfile(),
            //     builder: (BuildContext context, AsyncSnapshot snapshot) {
            //       if (snapshot.hasData) {
            //         return (snapshot.data);
            //       } else if (snapshot.error) {
            //         return Center(
            //           child: Text("No Contact blocked"),
            //         );
            //       } else {
            //         return CircularProgressIndicator();
            //       }
            //     })
          ),
        ),
      ),
    );
  }
}
