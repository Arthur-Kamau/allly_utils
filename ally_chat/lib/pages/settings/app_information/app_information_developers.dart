import 'package:flutter/material.dart';

class AppInformationDevelopers extends StatelessWidget {
  static String tag = 'app-information-developers-page';

  Widget _araizenTechnologies(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //show image modal
      },
      child: new ListTile(
        leading: new CircleAvatar(
            foregroundColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.grey,
            backgroundImage:
                new AssetImage('assets/images/developers/araizen.jpg')),
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text("Araizen Technologies",
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
          ],
        ),
        subtitle: new Container(
          padding: const EdgeInsets.only(top: 2.0),
          child: new Text("www.araizen.com",
              style: new TextStyle(color: Colors.black, fontSize: 12.0)),
        ),
      ),
    );
  }

  Widget _legitimateTechnologies(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //show image modal
      },
      child: new ListTile(
        leading: new CircleAvatar(
            foregroundColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.grey,
            backgroundImage:
                new AssetImage('assets/images/developers/araizen.jpg')),
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text("Legitimate Technologies",
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
          ],
        ),
        subtitle: new Container(
          padding: const EdgeInsets.only(top: 2.0),
          child: new Text("www.legitimateTech.com",
              style: new TextStyle(color: Colors.black, fontSize: 12.0)),
        ),
      ),
    );
  }

  Widget __koechTechnologies(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //show image modal
      },
      child: new ListTile(
        leading: new CircleAvatar(
            foregroundColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.grey,
            backgroundImage:
                new AssetImage('assets/images/developers/araizen.jpg')),
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text("collegine",
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
          ],
        ),
        subtitle: new Container(
          padding: const EdgeInsets.only(top: 2.0),
          child: new Text("www.birichi.xyz",
              style: new TextStyle(color: Colors.black, fontSize: 12.0)),
        ),
      ),
    );
  }

  Widget __shardieTechnologies(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //show image modal
      },
      child: new ListTile(
        leading: new CircleAvatar(
            foregroundColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.grey,
            backgroundImage:
                new AssetImage('assets/images/developers/araizen.jpg')),
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text("Shaddie",
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
          ],
        ),
        subtitle: new Container(
          padding: const EdgeInsets.only(top: 2.0),
          child: new Text("www.emongole.org",
              style: new TextStyle(color: Colors.black, fontSize: 12.0)),
        ),
      ),
    );
  }

  Widget _allyTeamTechnologies(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //show image modal
      },
      child: new ListTile(
        leading: new CircleAvatar(
            foregroundColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.white,
            backgroundImage:
                new AssetImage('assets/icons/Ally_icon_Blue.png')),
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text("Ally Team",
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
          ],
        ),
        subtitle: new Container(
          padding: const EdgeInsets.only(top: 2.0),
          child: new Text("www.----.xyz",
              style: new TextStyle(color: Colors.black, fontSize: 12.0)),
        ),
      ),
    );
  }

  Widget _contactDetails(BuildContext context) {
    return Column(
      children: <Widget>[
        _araizenTechnologies(context),
        _divider(),
        _legitimateTechnologies(context),
     //   _divider(),
     //   __koechTechnologies(context),
      //  _divider(),
       // __shardieTechnologies(context),
        _divider(),
        _allyTeamTechnologies(context)
      ],
    );
  }

  Widget _divider() {
    return Divider(
      height: 5.0,
    );
  }

  Widget _detaisContainer(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0),
      padding: EdgeInsets.all(5.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: _contactDetails(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _detaisContainer(context),
    );
  }
}
