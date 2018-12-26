import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'page.dart';

class PagerIndicator extends StatelessWidget {
  final PagerIndicatorViewModel pagerIndicatorViewModel;

  PagerIndicator({this.pagerIndicatorViewModel});

  @override
  Widget build(BuildContext context) {
    List<PageBubble> bubbles = [];
    for (var i = 0; i < pagerIndicatorViewModel.pages.length; ++i) {
      final page = pagerIndicatorViewModel.pages[i];

      double percentActive;
      if (i == pagerIndicatorViewModel.activeIndex) {
        percentActive = 1 - pagerIndicatorViewModel.slidePercent;
      } else if (i == pagerIndicatorViewModel.activeIndex - 1 &&
          pagerIndicatorViewModel.slideDirection ==
              SlideDirection.leftToRight) {
        percentActive = pagerIndicatorViewModel.slidePercent;
      } else if (i == pagerIndicatorViewModel.activeIndex + 1 &&
          pagerIndicatorViewModel.slideDirection ==
              SlideDirection.rightToLeft) {
        percentActive = pagerIndicatorViewModel.slidePercent;
      } else {
        percentActive = 0.0;
      }

      bool isHollow = i > pagerIndicatorViewModel.activeIndex ||
          (i == pagerIndicatorViewModel.activeIndex &&
              pagerIndicatorViewModel.slideDirection ==
                  SlideDirection.leftToRight);

      bubbles.add(new PageBubble(
          pageBubbleViewModel: new PageBubbleViewModel(
              color: page.color,
              iconAssetPath: page.iconAssetIcons,
              isHollow: isHollow,
              activePercent: percentActive)));
    }

    final  double bubbleWidth = 55.0;
    final double baseTranslation = ((pagerIndicatorViewModel.pages.length * bubbleWidth)/2) - bubbleWidth/2;
    double translation = baseTranslation - (pagerIndicatorViewModel.activeIndex * bubbleWidth);
    if (pagerIndicatorViewModel.slideDirection == SlideDirection.leftToRight){
      translation += bubbleWidth * pagerIndicatorViewModel.slidePercent;
    } else if (pagerIndicatorViewModel.slideDirection == SlideDirection.rightToLeft){
      translation -= bubbleWidth * pagerIndicatorViewModel.slidePercent;
    }

    return new Column(
      children: <Widget>[
        new Expanded(
          child: new Container(),
        ),
        new Transform(
            transform: new Matrix4.translationValues(translation, 0.0, 0.0),
            child: new Row(
                mainAxisAlignment: MainAxisAlignment.center, children: bubbles))
      ],
    );
  }
}

class PageBubble extends StatelessWidget {
  final PageBubbleViewModel pageBubbleViewModel;

  PageBubble({this.pageBubbleViewModel});

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 55.0,
      height: 65.0,
      child: new Center(
        child: new Container(
            width: ui.lerpDouble(20.0, 45.0, pageBubbleViewModel.activePercent),
            height:
                ui.lerpDouble(20.0, 45.0, pageBubbleViewModel.activePercent),
            decoration: new BoxDecoration(
                color: pageBubbleViewModel.isHollow
                    ? new Color(0x88FFFFFF).withAlpha(
                        (0x88 * pageBubbleViewModel.activePercent).round())
                    : new Color(0x88FFFFFF), //Showing a fill when not hollow
                shape: BoxShape.circle,
                border: new Border.all(
                    color: pageBubbleViewModel.isHollow
                        ? new Color(0x88FFFFFF).withAlpha(
                            (0x88 * (1 - pageBubbleViewModel.activePercent))
                                .round())
                        : Colors.transparent, //Showing border when is hollow
                    width: 3.0)),
            child: new Opacity(
              opacity: pageBubbleViewModel.activePercent,
              child: new Image.asset(
                pageBubbleViewModel.iconAssetPath,
                color: pageBubbleViewModel.color,
              ),
            )),
      ),
    );
  }
}

enum SlideDirection { leftToRight, rightToLeft, none }

class PagerIndicatorViewModel {
  final List<PageViewModel> pages;
  final int activeIndex;
  final SlideDirection slideDirection;
  final double slidePercent;

  PagerIndicatorViewModel(
      {this.pages, this.activeIndex, this.slideDirection, this.slidePercent});
}

class PageBubbleViewModel {
  final Color color;
  final String iconAssetPath;
  final bool isHollow;
  final double activePercent;

  PageBubbleViewModel(
      {this.color, this.iconAssetPath, this.isHollow, this.activePercent});
}
