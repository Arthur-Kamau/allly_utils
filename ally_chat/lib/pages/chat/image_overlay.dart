
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/***
 * image overlay
 */

class ImageOverlay extends ModalRoute<void> {
  String imagePath;

  ImageOverlay({this.imagePath});

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
            height: 200.0,
            width: 200.0,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(60.0),
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      'https://images.pexels.com/photos/935969/pexels-photo-935969.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940')),
              color: Colors.red, //transparent,
            ),
          )
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
