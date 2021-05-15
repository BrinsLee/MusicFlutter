
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_flutter/common/routes/routing_constants.dart';
import 'package:music_flutter/pages/discovery/discoveryPage.dart';
import 'package:music_flutter/pages/home/homePage.dart';
import 'package:music_flutter/pages/me/mePage.dart';
import 'package:music_flutter/pages/splash/splashPage.dart';
import 'package:music_flutter/pages/undefined/undefined.dart';
import 'package:music_flutter/pages/video/videoPage.dart';

List<String> navStack = ["Home"];

Route<dynamic> generateRoute(RouteSettings settings) {
  debugPrint(settings.name);
  switch (settings.name) {
    case splashRoute:
      navStack.add("Splash");
      return CupertinoPageRoute(builder: (context) => SplashPage());
    case homeRoute:
      navStack.add("Home");
      return PageRouteBuilder(
          pageBuilder: (context, anim1, anim2) => HomePage());
    case findRoute:
      navStack.add("Find");
      return PageRouteBuilder(
          pageBuilder: (context, anim1, anim2) => DiscoveryPage());
    case videoRoute:
      navStack.add("Video");
      return PageRouteBuilder(
          pageBuilder: (context, anim1, anim2) => VideoPage());
    case mineRoute:
      navStack.add("Mine");
      return PageRouteBuilder(
          pageBuilder: (context, anim1, anim2) => MePage());
    default:
      navStack.add("undefined");
      return CupertinoPageRoute(
        builder: (context) => UndefinedPage(
          name: settings.name,
        ),
      );
  }
}