import 'package:flutter/material.dart';

import 'package:register/pages/slides/homePage.dart';

class AllyLicencePage extends StatefulWidget {
  static String tag = 'licence-page';
  AllyLicencePage({
    Key key,
  }) : super(key: key);

  @override
  _LicencePageState createState() => _LicencePageState();
}

class _LicencePageState extends State<AllyLicencePage> {
  final _formKey = GlobalKey<FormState>();

  Padding buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '  Welcome to Ally.',
        style: TextStyle(
          fontSize: 32.0,
          color: Colors.blue
          ),
      ),
    );
  }

  Padding buildTitleLine() {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, left: 12.0),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 130.0,
          height: 1.5,
          color: Colors.black,
        ),
      ),
    );
  }

  Align acceptLicenceAndContinue(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 50.0,
        width: 270.0,
        child: FlatButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              //TODO Check values and navigate to new page
              Navigator.of(context).pushNamed(IntroSliderHomePage.tag);
            }
          },
          color: Colors.blue,//Colors.grey[900],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: Text(
            'Accept And Continue',
            style: Theme.of(context).primaryTextTheme.button,
          ),
        ),
      ),
    );
  }

  Widget _allyIcon() {
    return Center(
        child: Container(
      height: 250.0,
      width: 250.0,
      child: CircleAvatar(
          foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.transparent,
          backgroundImage: new AssetImage("assets/icons/Ally_icon_Blue.png")),
    ));
  }

  Widget _licenceText() {
    return Column(
      children: <Widget>[
        Text(
          'click "Accept And Continue" to accept',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
        Text(
          'Ally user licence and Privacy Policy',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 16.0,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 22.0),
          children: <Widget>[
            SizedBox(height: kToolbarHeight),
            buildTitle(),
            buildTitleLine(),
            SizedBox(
              height: 20.0,
            ),

            // SizedBox(height: 30.0,),
            // buildPasswordInput(context),
            // buildPasswordText(),
            SizedBox(
              height: 20.0,
            ),
            _allyIcon(),
            SizedBox(
              height: 30.0,
            ),
            _licenceText(),

            SizedBox(
              height: 20.0,
            ),
            acceptLicenceAndContinue(context),
          ],
        ),
      ),
    );
  }
}
