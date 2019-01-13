import 'package:ally_chat/pages/settings/account/account.dart';
import 'package:ally_chat/pages/settings/blocked/blocked.dart';
import 'package:ally_chat/pages/settings/logout_policy/logout_policy.dart';
import 'package:ally_chat/pages/settings/app_information/app_information.dart';
import 'package:ally_chat/pages/settings/archives/archives.dart';
import 'package:ally_chat/pages/settings/history/history.dart';
import 'package:ally_chat/pages/settings/licence/licence.dart';
import 'package:ally_chat/pages/settings/sync/sync.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:reminder_araizen/home/pages/account_details.dart';
import 'package:ally_chat/pages/transition/slide_right_transition.dart';
class MySettings extends StatefulWidget{
  static String tag = 'setting-page';
  MySettingsState createState()=>  MySettingsState();
}


class MySettingsState extends State<MySettings> {
  
  
  @override
  Widget build(BuildContext context){

    final appBar =  new AppBar(
            title: new Text("Settings"),
            leading: Icon(Icons.arrow_back),
            elevation: 0.7,
           automaticallyImplyLeading: true,
            actions: <Widget>[
            //  Row(
            //    mainAxisAlignment: MainAxisAlignment.start,
            //    crossAxisAlignment: CrossAxisAlignment.center,
            //    children: <Widget>[
            //      InkWell(
            //        child: new Icon(Icons.arrow_back),
            //       ),
            //       new Padding(padding: EdgeInsets.only(right: 20.0),),
            //       new Text("Settings"),
            //    ],
            //  )
            ]
         );

   final user_account = FlatButton(
        onPressed: (){
               // Navigator.of(context).pushNamed(AccountDetailsPage.tag);
                 Navigator.push(
                            context,
                            SlideRightRoute(widget: UserAccount()),
                          );
        },
        child: new Container(
         margin: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.fromLTRB( 10.0,0.0,20.0,0.0),
                  child: new Icon(
                    Icons.account_circle,
                     size: 30.0,
                  color: Colors.blue,
                    
                  ),
                ),
                new Text(
                  "Account ",
                  style: TextStyle(
                    fontSize: 14.0
                  ),
                )
              ],
            )

          ],
        ),
     ),
   );


_launchURL(String url) async {
 
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

   final helpWidget = FlatButton(
      onPressed: (){
        //open in browser
  _launchURL('https://flutter.io');
      },
      child: new Container(
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.fromLTRB( 25.0,10.0,20.0,0.0),
                  child: new Icon(
                    Icons.help,
                    size: 30.0,
                    color: Colors.blue,
                                 
                  ),
                ),
                new Text(
                  "Help",
                  style: TextStyle(
                    fontSize: 14.0
                  ),
                )
              ],
            )

          ],
        ),
     ),
   );

final historyWidget = FlatButton(
   onPressed: (){
     print("pressed");
      Navigator.of(context).pushNamed(HistoryPolicy.tag);
    
   },
  child:  new Container(
         margin: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.fromLTRB( 10.0,0.0,20.0,0.0),
                  child: new Icon(
                    Icons.archive, //clear_all,
                     size: 30.0,
                  color: Colors.blue,
  
                  ),
                ),
                new Text(
                  "Data policy",
                  style: TextStyle(
                    fontSize: 14.0
                  ),
                )
              ],
            )
  
          ],
        ),
     ),
);

final blockedWidget = FlatButton(
   onPressed: (){
     print("blocked");
      Navigator.of(context).pushNamed(BlockedUsersList.tag);
    
   },
  child:  new Container(
         margin: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.fromLTRB( 10.0,0.0,20.0,0.0),
                  child: new Icon(
                    Icons.clear_all,
                     size: 30.0,
                  color: Colors.blue,
  
                  ),
                ),
                new Text(
                  "Blocked",
                  style: TextStyle(
                    fontSize: 14.0
                  ),
                )
              ],
            )
  
          ],
        ),
     ),
);

final logutPolicyWidget = FlatButton(
   onPressed: (){
     print("pressed");
       Navigator.of(context).pushNamed(LogOutPolicy.tag);
      // Scaffold.of(context).showSnackBar( SnackBar( content: Text("Deleting history"), ));
   },
  child:  new Container(
         margin: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.fromLTRB( 10.0,0.0,20.0,0.0),
                  child: new Icon(
                    Icons.exit_to_app,
                    size: 30.0,
                    color: Colors.blue,
                  ),
                ),
                new Text(
                  "Log Out Policy",
                  style: TextStyle(
                    fontSize: 14.0
                  ),
                )
              ],
            )
  
          ],
        ),
     ),
);

final archivesPolicyWidget = FlatButton(
   onPressed: (){
     print("pressed");
      Navigator.of(context).pushNamed(ArchivesPolicy.tag);
    // Scaffold.of(context).showSnackBar( SnackBar(content: Text("Deleting history"),));
   },
  child:  new Container(
         margin: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.fromLTRB( 10.0,0.0,20.0,0.0),
                  child: new Icon(
                    Icons.archive,
                    size: 30.0,
                    color: Colors.blue,
  
                  ),
                ),
                new Text(
                  "Archives",
                  style: TextStyle(
                    fontSize: 14.0
                  ),
                )
              ],
            )
  
          ],
        ),
     ),
);

final syncWidget = FlatButton(
   onPressed: (){
     print("pressed");
      Navigator.of(context).pushNamed(SyncData.tag);
    // Scaffold.of(context).showSnackBar( SnackBar(content: Text("Deleting history"),));
   },
  child:  new Container(
         margin: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.fromLTRB( 10.0,0.0,20.0,0.0),
                  child: new Icon(
                    Icons.sync,
                    size: 30.0,
                    color: Colors.blue,
  
                  ),
                ),
                new Text(
                  "sync",
                  style: TextStyle(
                    fontSize: 14.0
                  ),
                )
              ],
            )
  
          ],
        ),
     ),
);

  final appInformationWidget = FlatButton(
    onPressed: (){
       Navigator.of(context).pushNamed(AppInformationPolicy.tag);
    },
      child: new Container(
         margin: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.fromLTRB( 25.0,0.0,20.0,0.0),
                  child: new Icon(
                    Icons.info,
                     size: 30.0,
                    color: Colors.blue,
    
                  ),
                ),
                new Text(
                  "App Information",
                  style: TextStyle(
                    fontSize: 14.0
                  ),
                )
              ],
            )

          ],
        ),
     ),
  );

  final licenceWidget = FlatButton(
    onPressed: (){
     //  Navigator.of(context).pushNamed(Applicence.tag);
       _launchURL('https://flutter.io');
    },
      child: new Container(
         margin: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.fromLTRB( 25.0,0.0,20.0,0.0),
                  child: new Icon(
                    Icons.bookmark,
                     size: 30.0,
                    color: Colors.blue,
                    
                  ),
                ),
                new Text(
                  "licence",
                  style: TextStyle(
                    fontSize: 14.0
                  ),
                )
              ],
            )

          ],
        ),
     ),
  );


final dividerWidget=new Center(
          child: new Divider(
            height: 10.0,
          ),
        );

    final settingsListContainer= Padding(
    child: Column(
      children: <Widget>[
        user_account,
         dividerWidget,
        // logutPolicyWidget,
       // dividerWidget,
       // historyWidget,
       // dividerWidget,
        blockedWidget,
       // dividerWidget,
      //  syncWidget,
        dividerWidget,
        helpWidget,
        dividerWidget,
        appInformationWidget,
        dividerWidget,
        licenceWidget,
      ],
    ),
    padding: EdgeInsets.all(5.0),
    );
  
    final body = new Container(
      child: settingsListContainer,
      
    );


      
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
          home: Scaffold(
        appBar: new AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: true,
          title: new Text("Settings"),
        ),
        body: body,
      ),
    );
  }
}