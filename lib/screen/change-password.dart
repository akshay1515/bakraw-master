import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/provider/changepasswordprovider.dart';
import 'package:bakraw/screen/dashboard.dart';
import 'package:bakraw/utils/GeoceryStrings.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:bakraw/utils/GroceryWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class GroceryChangePassword extends StatefulWidget {
  static String tag = '/GroceryChangePassword';

  @override
  _GroceryChangePasswordState createState() => _GroceryChangePasswordState();
}

class _GroceryChangePasswordState extends State<GroceryChangePassword> {
  SharedPreferences prefs;
  bool isLoading = false;
  GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();

  String email = '';
  String apikey = '';
  String userid = '';

  TextEditingController currentpasswordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  Future<String> getUserInfo() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      setState(() {
        email = prefs.getString('email');
        apikey = prefs.getString('apikey');
        userid = prefs.getString('id');
      });
    }
    return email;
  }

  @override
  void initState() {
    getUserInfo();
  }

  @override
  void dispose() {
    super.dispose();
    changeStatusColor(grocery_colorPrimary);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    changeStatusColor(grocery_color_white);
    return Scaffold(
      backgroundColor: grocery_app_background,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 65),
        child: title1('Change Password', grocery_color_white,
            grocery_textColorPrimary, context),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
                          offset: Offset(0.0, 0.9))
                    ]),
                child: Column(
                  children: <Widget>[
                    /*EditText(
                text: grocery_lbl_old_Password,
              ).paddingOnly(
                  top: spacing_standard_new,
                  left: spacing_standard_new,
                  right: spacing_standard_new),
              EditText(
                text: grocery_lbl_new_Password,
              ).paddingOnly(
                  top: spacing_standard_new,
                  left: spacing_standard_new,
                  right: spacing_standard_new),
              EditText(
                text: grocery_lbl_confirm_Password,
              ).paddingOnly(
                  top: spacing_standard_new,
                  left: spacing_standard_new,
                  right: spacing_standard_new),*/
                    Form(
                        key: _formKeyValue,
                        child: Column(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 10),
                                child: TextFormField(
                                  controller: currentpasswordController,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontSize: textSizeMedium,
                                        fontFamily: fontRegular),
                                    labelText: grocery_lbl_old_Password,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 5),
                                    hintText: grocery_lbl_old_Password,
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return 'Please Enter Your Current Password';
                                    }
                                  },
                                )),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 10),
                                child: TextFormField(
                                  obscureText: true,
                                  controller: newpasswordController,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontSize: textSizeMedium,
                                        fontFamily: fontRegular),
                                    labelText: grocery_lbl_new_Password,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 5),
                                    hintText: grocery_lbl_new_Password,
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return 'Please Add Your New Password';
                                    } else if (value.trim().length < 8) {
                                      return 'Password must be atleat 8 characters';
                                    }
                                  },
                                )),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 10),
                                child: TextFormField(
                                  controller: confirmpasswordController,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontSize: textSizeMedium,
                                        fontFamily: fontRegular),
                                    labelText: grocery_lbl_confirm_Password,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 5),
                                    hintText: grocery_lbl_confirm_Password,
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return 'Please Confirm New Password';
                                    } else if (value.trim() !=
                                        newpasswordController.text) {
                                      return 'Password Doesnot Match';
                                    }
                                  },
                                ))
                          ],
                        )),
                    SizedBox(
                      height: spacing_standard_new,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FittedBox(
                        child: groceryButton(
                          textContent: grocery_lbl_Save,
                          color: grocery_colorPrimary,
                          onPressed: (() {
                            setState(() {
                              isLoading = true;
                            });
                            if (_formKeyValue.currentState.validate() == true) {
                              final curr_pwd = currentpasswordController.text;
                              final new_pwd = newpasswordController.text;

                              Provider.of<Change_Password_Provider>(context,
                                      listen: false)
                                  .Change_Password(
                                      curr_pwd, new_pwd, apikey, email, userid)
                                  .then((value) {
                                if (value.status == 200) {
                                  currentpasswordController.clear();
                                  newpasswordController.clear();
                                  confirmpasswordController.clear();

                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text('Success'),
                                            content: Text(value.message),
                                            actions: <Widget>[
                                              FlatButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                    Navigator.of(context)
                                                        .pushReplacementNamed(
                                                            Dashboard.Tag);
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
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Ok'))
                                            ],
                                          ));
                                }
                              });
                            }
                          }),
                        )
                            .paddingOnly(
                                right: spacing_standard_new,
                                bottom: spacing_standard_new)
                            .paddingOnly(
                                top: spacing_standard_new,
                                bottom: spacing_standard_new),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
