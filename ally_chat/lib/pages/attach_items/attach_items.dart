import 'package:ally_chat/core/intent.dart';
import 'package:flutter/material.dart';
import 'package:ally_chat/pages/attach_items/video_screen.dart';
import 'package:ally_chat/pages/attach_items/contactrs_screen.dart';
import 'package:ally_chat/pages/attach_items/pictures_screen.dart';
import 'package:ally_chat/pages/attach_items/music_screen.dart';
import 'package:ally_chat/pages/attach_items/camera_screen.dart';
import 'package:ally_chat/pages/attach_items/apps_screen.dart';

class AttachItems extends StatefulWidget {
  static String tag = 'attch-items-page';
  String userChatName;
  String userChatPhoneNumber;
  String userChatMessage;

  AttachItems(
      {this.userChatName, this.userChatPhoneNumber, this.userChatMessage});

  _AttachItemsState createState() => _AttachItemsState();
}

class _AttachItemsState extends State<AttachItems>
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: new AppBar(
          // title: new Text("Ally App"),
          leading: Container(),
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
            new CameraScreen(
                userChatName: widget.userChatMessage,
                userChatPhoneNumber: widget.userChatPhoneNumber,
                userChatMessage: widget.userChatMessage),
            new ContactsScreen(
                userChatName: widget.userChatMessage,
                userChatPhoneNumber: widget.userChatPhoneNumber,
                userChatMessage: widget.userChatMessage),
            new PicturesScreen(
              intent: Intent.picturesScreenChatIntent,
                userChatName: widget.userChatMessage,
                userChatPhoneNumber: widget.userChatPhoneNumber,
                userChatMessage: widget.userChatMessage),
            new MusicScreen(
                userChatName: widget.userChatMessage,
                userChatPhoneNumber: widget.userChatPhoneNumber,
                userChatMessage: widget.userChatMessage),
            new VideoScreen(
                userChatName: widget.userChatMessage,
                userChatPhoneNumber: widget.userChatPhoneNumber,
                userChatMessage: widget.userChatMessage),
            new AppsScreen(
                userChatName: widget.userChatMessage,
                userChatPhoneNumber: widget.userChatPhoneNumber,
                userChatMessage: widget.userChatMessage),
          ],
        ),
      ),
    );
  }
}
