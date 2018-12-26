import 'package:flutter/material.dart';
import 'package:ally_utils/pages/chat/video_screen.dart';
import 'package:ally_utils/pages/chat/contactrs_screen.dart';
import 'package:ally_utils/pages/chat/pictures_screen.dart';
import 'package:ally_utils/pages/chat/music_screen.dart';
import 'package:ally_utils/pages/chat/camera_screen.dart';
import 'package:ally_utils/pages/chat/apps_screen.dart';

class WhatsAppClone extends StatefulWidget {
  static String tag = 'watsapp-page';
  _WhatsAppCloneState createState() => _WhatsAppCloneState();
}

class _WhatsAppCloneState extends State<WhatsAppClone>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, initialIndex: 2, length: 6);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        // title: new Text("Ally App"),

        elevation: 0.7,

        flexibleSpace: SafeArea(
          child: new TabBar(
            isScrollable: true,
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              new Tab(icon: new Icon(Icons.camera)),
              new Tab(
                  icon: new Text(
                "Contacts",
                style: TextStyle(
                  fontSize: 12.0,
                ),
              )),
              new Tab(
                  icon: new Text(
                "Pictures",
                style: TextStyle(
                  fontSize: 12.0,
                ),
              )),
              new Tab(
                  icon: new Text(
                "Audio",
                style: TextStyle(
                  fontSize: 12.0,
                ),
              )),
              new Tab(
                  icon: new Text(
                "Video",
                style: TextStyle(
                  fontSize: 12.0,
                ),
              )),
              new Tab(
                  icon: new Text(
                "Apps",
                style: TextStyle(
                  fontSize: 12.0,
                ),
              )),
            ],
          ),
        ),
        // actions: <Widget>[
        //   new Icon(
        //     Icons.search,
        //   ),
        //   new Padding(padding: const EdgeInsets.only(left: 5.0)),
        //   new Icon(Icons.more_vert)
        // ],
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          new CameraScreen(),
          new ContactsScreen(),
          new PicturesScreen(),
          new MusicScreen(),
          new VideoScreen(),
          new AppsScreen(),
        ],
      ),
    );
  }
}
