import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/usermodel.dart';
import 'package:bakraw/screen/dashboard.dart';
import 'package:bakraw/utils/GeoceryStrings.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:bakraw/utils/GroceryImages.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    changeStatusColor(grocery_colorPrimary);

    Future.delayed(Duration(seconds: 2), () async {
      Navigator.of(context).pushReplacementNamed(Dashboard.Tag);
    });

    return Scaffold(
      backgroundColor: grocery_colorPrimary,
      body: Image.asset('images/Bakraw-android-app-Splash.jpg',
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.contain           ,
      )
    );
  }
}
