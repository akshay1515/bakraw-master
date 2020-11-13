import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/screen/signup.dart';
import 'package:bakraw/utils/GeoceryStrings.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:bakraw/utils/GroceryWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DefaultUserProfile extends StatelessWidget {
  bool istab = false;

  DefaultUserProfile({this.istab});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    changeStatusColor(grocery_colorPrimary);

    return istab
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                Center(
                  child: FittedBox(
                    child: groceryButton(
                      bgColors: grocery_colorPrimary,
                      textContent: grocery_lbl_Sign_In,
                      onPressed: (() {
                        SignUp(
                          isSignIn: true,
                          isSignUp: false,
                        ).launch(context);
                      }),
                    ),
                  ),
                ),
                SizedBox(
                  height: spacing_standard,
                ),
                Center(
                  child: FittedBox(
                      child: groceryButton(
                    bgColors: grocery_colorPrimary,
                    textContent: grocery_lbl_Sign_Up,
                    onPressed: (() {
                      SignUp(
                        isSignUp: true,
                        isSignIn: false,
                      ).launch(context);
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
                  Center(
                    child: FittedBox(
                      child: groceryButton(
                        bgColors: grocery_colorPrimary,
                        textContent: grocery_lbl_Sign_In,
                        onPressed: (() {
                          SignUp(
                            isSignIn: true,
                            isSignUp: false,
                          ).launch(context);
                        }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: spacing_standard,
                  ),
                  Center(
                    child: FittedBox(
                        child: groceryButton(
                      bgColors: grocery_colorPrimary,
                      textContent: grocery_lbl_Sign_Up,
                      onPressed: (() {
                        SignUp(
                          isSignUp: true,
                          isSignIn: false,
                        ).launch(context);
                      }),
                    )),
                  )
                ]).paddingOnly(bottom: spacing_xxLarge));
  }
}
