import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/usermodel.dart';
import 'package:bakraw/provider/userprovider.dart';
import 'package:bakraw/screen/addnumber.dart';
import 'package:bakraw/screen/dashboard.dart';
import 'package:bakraw/screen/forgotpassword.dart';
import 'package:bakraw/utils/GeoceryStrings.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:bakraw/utils/GroceryWidget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  static String tag = '/GrocerySignUp';
  bool isSignIn = true;
  bool isSignUp = false;

  SignUp({this.isSignIn, this.isSignUp});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  void dispose() {
    super.dispose();
    changeStatusColor(grocery_colorPrimary);
  }

  SharedPreferences prefs;
  bool isLoading = false;

  GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  GlobalKey<FormState> _Signupformkey = new GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    changeStatusColor(grocery_color_white);

    Future setUser(UserModel userModel) async {
      prefs = await SharedPreferences.getInstance();

      await prefs.setString('id', userModel.data.userId);
      await prefs.setString('email', userModel.data.email);
      await prefs.setString('fname', userModel.data.firstName);
      await prefs.setString('lname', userModel.data.lastName);
      await prefs.setString('mobile', userModel.data.phoneNumber);
      await prefs.setString('password', userModel.data.password);
      await prefs.setString('apikey', userModel.data.token);
    }

    final signIn = Container(
        child: SingleChildScrollView(
      child: Form(
        key: _formKeyValue,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: Colors.white12.withOpacity(0.2),
              ))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  text(grocery_lbl_sigIn_App,
                          fontSize: textSizeLarge, fontFamily: fontBold)
                      .paddingOnly(
                          top: spacing_standard_new,
                          left: spacing_standard_new,
                          right: spacing_standard_new),
                  text(
                    grocery_lbl_Enter_email_password_to_continue,
                    textColor: grocery_textColorSecondary,
                    fontSize: textSizeLargeMedium,
                  ).paddingOnly(
                      left: spacing_standard_new, right: spacing_standard_new),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    child: TextFormField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontSize: textSizeMedium, fontFamily: fontRegular),
                        labelText: grocery_lbl_Email_Address,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                        hintText: grocery_lbl_Email_Address,
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return 'Please Enter Your Email Address';
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontSize: textSizeMedium, fontFamily: fontRegular),
                        labelText: grocery_lbl_Password,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                        hintText: grocery_lbl_Password,
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return 'Please Enter Your Password';
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      text(
                        "$grocery_lbl_Forgot_password?",
                        fontSize: textSizeLargeMedium,
                        fontFamily: fontMedium,
                      )
                          .paddingOnly(
                              left: spacing_standard_new,
                              right: spacing_standard_new,
                              bottom: spacing_standard_new)
                          .onTap(() {
                        Navigator.of(context)
                            .pushNamed(GroceryForgotPassword.tag);
                      }),
                      groceryButton(
                        textContent: grocery_lbl_Sign_In,
                        onPressed: (() {
                          if (_formKeyValue.currentState.validate() == true) {
                            setState(() {
                              isLoading = true;
                            });
                            Provider.of<UserProvider>(context, listen: false)
                                .userlogin(UserloginModel(
                                    email: emailcontroller.text,
                                    password: passwordController.text))
                                .then((value) {
                              if (value.status == 200) {
                                setUser(value).then((sample) {
                                  setState(() {
                                    isLoading = false;
                                    emailcontroller.clear();
                                    passwordController.clear();
                                  });
                                });
                                Fluttertoast.showToast(
                                    msg: value.message,
                                    toastLength: Toast.LENGTH_SHORT);
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    Dashboard.Tag,
                                    (Route<dynamic> route) => false);
                              } else {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text('Login Error'),
                                          content: Text(value.message),
                                          actions: <Widget>[
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                },
                                                child: Text('Ok'))
                                          ],
                                        ));
                              }
                            });
                          }
                          //}
                        }),
                      )
                          .paddingOnly(
                              right: spacing_standard_new,
                              bottom: spacing_standard_new)
                          .paddingOnly(
                              top: spacing_standard_new,
                              bottom: spacing_standard_new)
                    ],
                  )
                ],
              ),
      ),
    ));

    final signUp = Container(
      child: Form(
        key: _Signupformkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            text(grocery_lbl_Welcome_app,
                    fontSize: textSizeLarge, fontFamily: fontBold)
                .paddingOnly(
                    top: spacing_standard_new,
                    left: spacing_standard_new,
                    right: spacing_standard_new),
            text(grocery_lbl_let_Started,
                    textColor: grocery_textColorSecondary,
                    fontSize: textSizeLargeMedium,
                    fontFamily: fontRegular)
                .paddingOnly(
                    left: spacing_standard_new, right: spacing_standard_new),
            Container(
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              child: TextFormField(
                controller: fnameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  hintStyle: TextStyle(
                      fontSize: textSizeMedium, fontFamily: fontRegular),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  hintText: 'First Name',
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Please Enter Your First Name';
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              child: TextFormField(
                controller: lnameController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                      fontSize: textSizeMedium, fontFamily: fontRegular),
                  labelText: 'Last Name',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  hintText: 'Last Name',
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Please Enter Your Last Name';
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              child: TextFormField(
                controller: emailcontroller,
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                      fontSize: textSizeMedium, fontFamily: fontRegular),
                  labelText: grocery_lbl_Email_Address,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  hintText: grocery_lbl_Email_Address,
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Please Enter Your Email Address';
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                      fontSize: textSizeMedium, fontFamily: fontRegular),
                  labelText: grocery_lbl_Password,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  hintText: grocery_lbl_Password,
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Please Enter Your Email Address';
                  }
                },
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FittedBox(
                child: groceryButton(
                  textContent: grocery_lbl_Next,
                  onPressed: (() {
                    if (_Signupformkey.currentState.validate() == true) {
                      setState(() {
                        isLoading = true;
                      });
                      var fname = fnameController.text;
                      var lname = lnameController.text;
                      var password = passwordController.text;
                      var email = emailcontroller.text;

                      setState(() {
                        isLoading = false;
                      });
                      Navigator.of(context).pushNamed(GroceryAddNumber.tag,
                          arguments: {
                            'fname': fname,
                            'lname': lname,
                            'email': email,
                            'password': password
                          });
                    }
                  }),
                ).paddingOnly(
                    right: spacing_standard_new, bottom: spacing_standard_new),
              ).paddingOnly(
                  top: spacing_standard_new, bottom: spacing_standard_new),
            )
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: grocery_app_background,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: spacing_large,
                  ),
                  Container(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            text("Sign In",
                                    textColor: widget.isSignIn == true
                                        ? grocery_textGreenColor
                                        : grocery_textColorPrimary,
                                    fontSize: textSizeLargeMedium,
                                    fontFamily: fontBold)
                                .paddingAll(spacing_standard_new)
                                .onTap(() {
                              widget.isSignIn = true;
                              widget.isSignUp = false;
                              setState(() {});
                            }),
                            text("Sign Up",
                                    textColor: widget.isSignUp == true
                                        ? grocery_textGreenColor
                                        : grocery_textColorPrimary,
                                    fontSize: textSizeLargeMedium,
                                    fontFamily: fontBold)
                                .paddingAll(spacing_standard_new)
                                .onTap(() {
                              widget.isSignIn = false;
                              widget.isSignUp = true;
                              setState(() {});
                            })
                          ],
                        ),
                        widget.isSignUp ? signUp : signIn
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
