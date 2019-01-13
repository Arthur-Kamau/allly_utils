import 'package:ally_chat/pages/chat/chat_history.dart';
import 'package:ally_chat/pages/profile/profile.dart';
import 'package:ally_chat/pages/settings/account/account.dart';
import 'package:ally_chat/pages/settings/settings.dart';
import 'package:ally_chat/pages/transition/slide_right_transition.dart';
import 'package:flutter/material.dart';

class MainBottomModal {
  BuildContext context;

  MainBottomModal({@required this.context});

  var divide = Container(
    margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
    child: new Divider(
      height: 10.0,
    ),
  );
  Widget _settings_menu_button(BuildContext context) {
    return new Container(
      child: FlatButton(
        child: Column(
          children: <Widget>[
            Icon(
              Icons.settings,
              size: 30.0,
              color: Colors.blue,
            ),
            Text(
              "Settings",
              style: TextStyle(fontSize: 10.0),
            )
          ],
        ),
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            SlideRightRoute(widget: MySettings()),
          );
        },
      ),
    );
  }

  Widget profile_menu_button(BuildContext context) {
    return new Container(
      child: FlatButton(
        child: Column(
          children: <Widget>[
            Icon(
              Icons.account_circle,
              size: 30.0,
              color: Colors.blue,
            ),
            Text(
              "profile",
              style: TextStyle(fontSize: 10.0),
            )
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            SlideRightRoute(widget: UserProfile()),
          );
        },
      ),
    );
  }

  Future<void> MainBottomModalDialog() {
    return showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
              // color: Colors.black,
              height: 100.0,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // divide,
                      //bottom row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          _settings_menu_button(context),
                          profile_menu_button(context),
                        ],
                      ),
                      // divide,
                    ],
                  )));
        });
  }
}
