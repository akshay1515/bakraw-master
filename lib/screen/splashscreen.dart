import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/screen/newui/newhomepage.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final globalScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    changeStatusColor(grocery_colorPrimary);

    Future.delayed(Duration(seconds: 2), () async {
      Navigator.of(context).pushReplacementNamed(NewHomepage.Tag);
    });

    return Scaffold(
        key: globalScaffoldKey,
        backgroundColor: grocery_colorPrimary,
        body: Image.asset(
          'images/Bakraw-android-app-Splash.jpg',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.contain,
        ));
  }
}
