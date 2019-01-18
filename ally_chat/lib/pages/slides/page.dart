import 'package:ally_chat/pages/login_register/login.dart';
import 'package:ally_chat/pages/login_register/register.dart';
import 'package:flutter/material.dart';

final List<PageViewModel> pages = [
  new PageViewModel(
      id: 1,
      totalNumber: 4,
      color: new Color(0xFF678FB4),
      heroAssetPath: "assets/images/slider/hotels.png",
      title: "Discover",
      body: "find new friends near you .",
      iconAssetIcons: "assets/images/slider/key.png"),
  new PageViewModel(
      id: 2,
      totalNumber: 4,
      color: new Color(0xFF65B0B4),
      heroAssetPath: "assets/images/slider/banks.png",
      title: "Transfer",
      body: "Transfer files with no data,moivies, music ..",
      iconAssetIcons: "assets/images/slider/wallet.png"),
  new PageViewModel(
      id: 3,
      totalNumber: 4,
      color: new Color(0xFF9B90BC),
      heroAssetPath: "assets/images/slider/stores.png",
      title: "Bulk Sharing",
      body: "Transfer multiple files without file size limits",
      iconAssetIcons: "assets/images/slider/shopping_cart.png"),
  new PageViewModel(
      id: 4,
      totalNumber: 4,
      color: new Color(0xFF8B99BC),
      heroAssetPath: "assets/images/slider/stores.png",
      title: "Welcome",
      body: " Enjoy !!",
      iconAssetIcons: "assets/images/slider/shopping_cart.png"),
];

class Page extends StatelessWidget {
  final PageViewModel viewModel;
  final double percentVisible;

  Page({this.viewModel, this.percentVisible: 1.0});

  Widget _registerButton(BuildContext context) {
    setState() {
      _opacityLevel = 0.0;
    }

    return Container(
      margin: EdgeInsets.only(top: 10.0),
      height: 50.0,
      width: 140.0,
      child: FlatButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Colors.white30,
        child: Text(
          "Register",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          // Navigator.pushNamed(context, RegisterPage.tag);

          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (BuildContext context) {
            return new RegisterPage();
          }));
        },
      ),
    );
  }

  Widget _ignoreText() {
    setState() {
      _opacityLevel = 1.0;
    }

    return Text("");
  }

  double _opacityLevel = 1.0;
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      color: viewModel.color,
      child: new Opacity(
        opacity: percentVisible,
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Transform(
                transform: new Matrix4.translationValues(
                    0.0, 50.0 * (1.0 - percentVisible), 0.0),
                child: new Container(
                  height: 250.0,
                  width: 450.0,
                  //color: Colors.red,
                  padding: new EdgeInsets.only(bottom: 25.0),
                  child: Stack(
                    children: <Widget>[
                      new Positioned(
                          // draw a red marble
                          top: 0.0,
                          right: 0.0,
                          child: Container(
                            padding: EdgeInsets.all(3.0),
                            child: Container(
                              margin: EdgeInsets.only(left: 30.0),
                              child: FlatButton(
                                color: Colors.white30,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Text(
                                  " skip all ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, LogInPage.tag);
                                },
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.transparent,
                            ),
                          )),
                      Container(
                        padding: EdgeInsets.only(left: 30.0),
                        child: new Image.asset(
                          viewModel.heroAssetPath,
                          width: 200.0,
                          height: 200.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              new Transform(
                transform: new Matrix4.translationValues(
                    0.0, 30.0 * (1.0 - percentVisible), 0.0),
                child: new Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                  child: new Text(viewModel.title,
                      style: new TextStyle(
                          fontSize: 34.0,
                          color: Colors.white,
                          fontFamily: "FlamanteRoma")),
                ),
              ),
              new Transform(
                transform: new Matrix4.translationValues(
                    0.0, 30.0 * (1.0 - percentVisible), 0.0),
                child: new Container(
                  padding: const EdgeInsets.only(bottom: 50.0, top: 0.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: new Text(
                          viewModel.body,
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                              fontFamily: "FlamanteRoma",
                              fontSize: 18.0,
                              color: Colors.white),
                        ),
                      ),
                      viewModel.id == viewModel.totalNumber
                          ? _registerButton(context)
                          : _ignoreText(),
                    ],
                  ),
                ),
              )
            ]),
      ),
    );
  }
}

class PageViewModel {
  int id;
  int totalNumber;
  final Color color;
  final String heroAssetPath;
  final String title;
  final String body;
  final String iconAssetIcons;

  PageViewModel(
      { // {} makes the parameters optional but helps with supplying name parameters
      this.id,
      this.totalNumber,
      this.color: Colors
          .pink, //after colon values are default values which are used when the parameter isn't passed
      this.heroAssetPath,
      this.title: "Title",
      this.body: "Body",
      this.iconAssetIcons});
}
