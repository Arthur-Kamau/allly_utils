import 'package:chat/pages/bottom_modal/main_bottom_modal/main_bottom_modal.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:chat/pages/settings/settings_main.dart';
import 'package:chat/objects/app_style.dart';

class UserPrivateProfile extends StatefulWidget {
  static String tag = 'User-Public-Profile-page';
  String userId;
  UserPrivateProfile({this.userId});
  _PublicProfilePageState createState() => _PublicProfilePageState();
}

class _PublicProfilePageState extends State<UserPrivateProfile> {
  Widget _menuVert(BuildContext context) {
    return PopupMenuButton(
        onSelected: (choice) {
          if (choice == PopMenuDetails.blockContact) {
            print("block contact");
          } else if (choice == PopMenuDetails.deleteContact) {
            print("delete contact");
          } else if (choice == PopMenuDetails.homeScreen) {
            print("add to home screen ");
          } else if (choice == PopMenuDetails.shareContact) {
            print("share contact");
            // _showFeedbackDialog();
          } else if (choice == PopMenuDetails.editContact) {
            print("edit contact");
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

  Widget _audioCallButton() {
    return Container(
      margin: EdgeInsets.all(1.0),
      width: 40.0,
      height: 80.0,
      child: Column(
        children: <Widget>[
          Material(
            type: MaterialType.circle,
            child: InkWell(
                child: Container(
                  child: Icon(Icons.mic, size: 20.0, color: Colors.white),
                  width: 40.0,
                  height: 40.0,
                ),
                onTap: () {}),
            elevation: 12.0,
            color: GetAppStyle.getColor(),
          ),
          SizedBox(height: 15.0),
          Text(
            "Audio",
            style: TextStyle(color: Colors.black, fontSize: 15.0),
          )
        ],
      ),
    );
  }

  Widget _videoCallButton() {
    return Container(
      margin: EdgeInsets.all(1.0),
      width: 40.0,
      height: 80.0,
      child: Column(
        children: <Widget>[
          Material(
            type: MaterialType.circle,
            child: InkWell(
                child: Container(
                  child:
                      Icon(Icons.video_call, size: 20.0, color: Colors.white),
                  width: 40.0,
                  height: 40.0,
                ),
                onTap: () {}),
            elevation: 12.0,
            color: GetAppStyle.getColor(),
          ),
          SizedBox(height: 15.0),
          Text(
            "Video",
            style: TextStyle(color: Colors.black, fontSize: 15.0),
          )
        ],
      ),
    );
  }

  Future<Null> _showCallOptionDialogue(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Call Option'),
            children: <Widget>[
              Row(
                children: <Widget>[
                  SimpleDialogOption(
                    onPressed: () {
                      /* Navigator.pop(context, Department.treasury); */
                    },
                    child: _videoCallButton(),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      /* Navigator.pop(context, Department.state); */
                    },
                    child: _audioCallButton(),
                  ),
                ],
              ),
              SimpleDialogOption(
                onPressed: () {
                  /* Navigator.pop(context, Department.treasury); */
                },
                child: Text(" "),
              ),
            ],
          );
        });
  }

  Widget _topBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      color: GetAppStyle.getColor(),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: new Icon(Icons.arrow_back, size: 24.0, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: Text(""),
          ),
          IconButton(
            icon: Icon(Icons.call, color: Colors.white),
            onPressed: () {
              _showCallOptionDialogue(context);
            },
          ),
          _menuVert(context),
        ],
      ),
    );
  }

  Widget _userAvater() {
    return new CircleAvatar(
      minRadius: 55.0,
      maxRadius: 65.0,
      backgroundImage: new AssetImage('assets/images/kenn.jpg'),
    );
  }

  Widget _divider() {
    return Divider(
      height: 5.0,
    );
  }

  void _showOverlay(BuildContext context) {
    Navigator.of(context).push(ImageOverlay(
        imageUrl:
            'https://images.pexels.com/photos/935969/pexels-photo-935969.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'));
  }

  Widget _contactDetails(BuildContext context) {
    return Container(
      color: GetAppStyle.getColor(),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              //show image modal
              print("show image");
              _showOverlay(context);
            },
            child: new ListTile(
              leading: new Container(
                height: 40.0,
                width: 40.0,

                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(60.0),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          'https://images.pexels.com/photos/935969/pexels-photo-935969.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940')),
                  color: Colors.red, //transparent,
                ),
                // new AssetImage(
                //     'assets/images/kenn.jpg'),
              ),
              title: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text("kenn kamau",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
              subtitle: new Container(
                padding: const EdgeInsets.only(top: 2.0),
                child: new Text("last seen 10-08-2018",
                    style: new TextStyle(color: Colors.white, fontSize: 12.0)),
              ),
            ),
          ),
        ],
      ),
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
          _divider(),
          new ListTile(
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("Phone number",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
              ],
            ),
            subtitle: new Container(
              padding: const EdgeInsets.only(top: 2.0),
              child: new Text("07119110910129",
                  style: new TextStyle(color: Colors.black, fontSize: 12.0)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Column(
        children: <Widget>[
          _topBar(context),
          _contactDetails(context),
          _userdetails()
        ],
      )),
    );
  }
}

class PopMenuDetails {
  static const String shareContact = 'Share ';
  static const String blockContact = 'Block ';
  static const String editContact = 'Edit contact';
  static const String deleteContact = 'Delete contact';
  static const String homeScreen = 'Add to Home screen';

  static const List<String> choices = [
    shareContact,
    blockContact,
    editContact,
    deleteContact,
    homeScreen,
  ];
}

/***
 * image overlay
 */

class ImageOverlay extends ModalRoute<void> {
  String imageUrl;

  ImageOverlay({this.imageUrl});

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 50.0, right: 50.0),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  size: 50,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Center(
            child: new Container(
              height: 120.0,
              width: 120.0,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(60.0),
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: CachedNetworkImageProvider(imageUrl)),
                color: Colors.red, //transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
