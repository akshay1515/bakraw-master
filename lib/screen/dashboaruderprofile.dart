import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/screen/addnumber.dart';
import 'package:bakraw/screen/signup.dart';
import 'package:bakraw/utils/GeoceryStrings.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:bakraw/utils/GroceryWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DefaultUserProfile extends StatefulWidget {
  bool istab = false;

  DefaultUserProfile({this.istab});

  @override
  _DefaultUserProfileState createState() => _DefaultUserProfileState();
}

class _DefaultUserProfileState extends State<DefaultUserProfile> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    changeStatusColor(grocery_colorPrimary);

    Future<String> getUserInfo() async {
      SharedPreferences prefs;
      prefs = await SharedPreferences.getInstance();
      if (prefs != null) {
        setState(() {
          String email = prefs.getString('email');
          String apikey = prefs.getString('apikey');
          String userid = prefs.getString('id');
          String fname = prefs.getString('fname');
          String lname = prefs.getString('lname');
          String  mobile = prefs.getString('mobile');
        });
      }
      print('shared pref${prefs.toString()}');
    }

    return widget.istab
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                SizedBox(
                  height: spacing_standard,
                ),
                Center(
                  child: FittedBox(
                      child: groceryButton(
                    bgColors: grocery_colorPrimary,
                    textContent: grocery_lbl_Sign_Up,
                    onPressed: (() {
                      GroceryAddNumber().launch(context);
                    }),
                  )),
                )
              ]).paddingOnly(bottom: spacing_xxLarge)
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: grocery_color_white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              title: Text(
                'GoatMeat',
                style: TextStyle(color: grocery_color_white),
              ),
            ),
            backgroundColor: grocery_color_white,
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: spacing_standard,
                  ),
                  Center(
                    child: FittedBox(
                        child: groceryButton(
                      bgColors: grocery_colorPrimary,
                      textContent: grocery_lbl_Sign_Up,
                      onPressed: (() {
                        SignUp().launch(context);
                      }),
                    )),
                  )
                ]).paddingOnly(bottom: spacing_xxLarge));
  }
}
