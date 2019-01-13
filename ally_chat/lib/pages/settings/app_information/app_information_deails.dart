import 'package:flutter/material.dart';

class AppInformtaionDetails extends StatelessWidget {
  
  static String tag = 'app-information-details-page';

  Widget _allyavatar() {
    return new Container(
      // color: Colors.white,
        height: 90.0,
        width: 90.0,

        child: FlatButton(
          onPressed: () {
            print("pressed");
          },
          child: new CircleAvatar(
            backgroundColor: Colors.transparent,
            minRadius: 75.0,
            maxRadius: 75.0,
            backgroundImage: new AssetImage('assets/icons/Ally_icon_Blue.png'),
          ),
        ));
  }

Widget _topBar(){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment:  MainAxisAlignment.center,
    children: <Widget>[
      
  _allyavatar(),
          Text(
            "Ally Super App",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
            ),
          ),
  ],);
}
  Widget _detailsContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
        _topBar(),
          SizedBox(
            height: 20.0,
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            child: Text("""
Your are Currently running Ally Super App Version 4.0.0.

  """),
          ),
          Container(
            child: Text(
              """
  Copyright 2014 - ${DateTime.now().year} \n
  Ally Super app ltd
  """,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:_detailsContainer(context),
    );
  }
}