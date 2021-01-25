/*
import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/usermodel.dart';
import 'package:bakraw/provider/passwordprovider.dart';
import 'package:bakraw/screen/signup.dart';
import 'package:bakraw/utils/GeoceryStrings.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:bakraw/utils/GroceryWidget.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class GroceryForgotPassword extends StatefulWidget {
  static String tag = '/GroceryForgotPassword';

  @override
  _GroceryForgotPasswordState createState() => _GroceryForgotPasswordState();
}

class _GroceryForgotPasswordState extends State<GroceryForgotPassword> {
  TextEditingController forgot = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    changeStatusColor(grocery_colorPrimary);

    return Scaffold(
      backgroundColor: grocery_app_background,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70),
        child: title(grocery_lbl_Forgot_password, grocery_colorPrimary,
            grocery_color_white, context),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: width,
          decoration: BoxDecoration(
            color: grocery_color_white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: const Radius.circular(20.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: grocery_ShadowColor,
                  blurRadius: 20.0,
                  offset: Offset(0.0, 0.9)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: spacing_standard),
              text(grocery_lbl_Reset_Password,
                      fontSize: textSizeLarge, fontFamily: fontBold)
                  .paddingOnly(
                      top: spacing_standard_new,
                      left: spacing_standard_new,
                      right: spacing_standard_new),
              text(
                grocery_lbl_enter_email_for_reset_password,
                textColor: grocery_textColorSecondary,
                fontSize: textSizeLargeMedium,
              ).paddingOnly(
                  left: spacing_standard_new, right: spacing_standard_new),
              SizedBox(height: spacing_standard_new),
              EditText(
                text: grocery_lbl_Email_Address,
                isPassword: false,
                mController: forgot,
                keyboardType: TextInputType.emailAddress,
              ).paddingAll(spacing_standard_new),
              Align(
                alignment: Alignment.centerRight,
                child: FittedBox(
                  child: groceryButton(
                    bgColors: grocery_colorPrimary,
                    textContent: grocery_lbl_send,
                    onPressed: (() {
                      */
/*print(forgot.text);*//*

                      if (forgot.text.isEmptyOrNull) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('Email Required'),
                                  content: Text(
                                      'Your Email is Required to reset password'),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Ok'))
                                  ],
                                ));
                      } else {
                        Provider.of<ForgotProvider>(context, listen: false)
                            .userlogin(UserloginModel(email: forgot.text))
                            .then((value) {
                          if (value.status == 200) {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text('Reset Success'),
                                      content: Text(value.message),
                                      actions: <Widget>[
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (ctx) => SignUp(
                                                            isSignIn: true,
                                                            isSignUp: false,
                                                          )));
                                            },
                                            child: Text('Ok'))
                                      ],
                                    ));
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text('Error'),
                                      content: Text(value.message),
                                      actions: <Widget>[
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              forgot.clear();
                                            },
                                            child: Text('Ok'))
                                      ],
                                    ));
                          }
                        });
                      }
                    }),
                  ).paddingOnly(
                      right: spacing_standard_new,
                      bottom: spacing_standard_new),
                ).paddingOnly(
                    top: spacing_standard_new, bottom: spacing_standard_new),
              )
            ],
          ),
        ),
      ),
    );
  }
}
*/
