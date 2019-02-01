import 'package:database_ally/pages/Interests/Interest_select_many.dart';
import 'package:database_ally/pages/Interests/Interest_select_one.dart';
import 'package:database_ally/pages/account/account.dart';
import 'package:database_ally/pages/account/change_email.dart';
import 'package:database_ally/pages/account/change_location.dart';
import 'package:database_ally/pages/account/change_name.dart';
import 'package:database_ally/pages/account/change_number.dart';
import 'package:database_ally/pages/account/change_status.dart';
import 'package:database_ally/pages/account/change_what_i_do.dart';
import 'package:database_ally/pages/attach_items/apps_screen.dart';
import 'package:database_ally/pages/attach_items/attach_items.dart';
import 'package:database_ally/pages/attach_items/camera_screen.dart';
import 'package:database_ally/pages/attach_items/contactrs_screen.dart';
import 'package:database_ally/pages/attach_items/music_screen.dart';
import 'package:database_ally/pages/attach_items/pictures_screen.dart';
import 'package:database_ally/pages/attach_items/video_screen.dart';
import 'package:database_ally/pages/blocked/blocked.dart';
import 'package:database_ally/pages/contacts/contacts_select_many.dart';
import 'package:database_ally/pages/contacts/contacts_select_one.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    //BlockedUsersList
    BlockedUsersList.tag: (context) => BlockedUsersList(),
//account profile
    UserAccount.tag: (context) => UserAccount(),
//attch items
    AppsScreen.tag: (context) => AppsScreen(),
    AttachItems.tag: (context) => AttachItems(),
    CameraScreen.tag: (context) => CameraScreen(),
    ContactsScreen.tag: (context) => ContactsScreen(),
    MusicScreen.tag: (context) => MusicScreen(),
    PicturesScreen.tag: (context) => PicturesScreen(),
    VideoScreen.tag: (context) => VideoScreen(),

//interest
    SelectInterestMany.tag: (context) => SelectInterestMany(),
    SelectInterestOne.tag: (context) => SelectInterestOne(),

//contacts
    ContactSelectMany.tag: (context) => ContactSelectMany(),
    ContactSelectOne.tag: (context) => ContactSelectOne(),

//account

    UserAccount.tag: (context) => UserAccount(),
    AccountChangeEmail.tag: (context) => AccountChangeEmail(),
    AccountChangeNumber.tag: (context) => AccountChangeNumber(),
    AccountChangeStatus.tag: (context) => AccountChangeStatus(),
    AccountChangeName.tag: (context) => AccountChangeName(),
    AccountChangeWhatIDo.tag: (context) => AccountChangeWhatIDo(),
    AccountChangeLocation.tag: (context) => AccountChangeLocation(),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _openBlocked() {
    Navigator.pushNamed(context, BlockedUsersList.tag);
  }

  void _openAccountProfile() {
    Navigator.pushNamed(context, UserAccount.tag);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("blocked contacts"),
              onPressed: _openBlocked,
            ),
            RaisedButton(
              child: Text("user profile"),
              onPressed: _openAccountProfile,
            )
          ],
        ),
      ),
    );
  }
}
