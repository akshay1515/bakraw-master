import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            grocery_ic_logo,
            width: width * 0.35,
            height: width * 0.35,
            fit: BoxFit.fill,
          ).center(),
          Padding(
            padding: const EdgeInsets.all(spacing_standard_new),
            child: text(grocery_lbl_Welcome_msg,
                    textColor: grocery_color_white,
                    fontSize: textSizeXXLarge,
                    fontFamily: fontSemiBold,
                    isCentered: true,
                    isLongText: true)
                .paddingOnly(left: spacing_control, right: spacing_control),
          )
        ],
      ),
    );
  }
}
