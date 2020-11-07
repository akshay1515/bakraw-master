import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/usermodel.dart';
import 'package:bakraw/provider/userprovider.dart';
import 'package:bakraw/screen/dashboard.dart';
import 'package:bakraw/utils/GeoceryStrings.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:bakraw/utils/GroceryWidget.dart' as GW;
import 'package:bakraw/utils/codePicker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroceryAddNumber extends StatefulWidget {
  static String tag = '/GroceryAddNumber';

  @override
  _GroceryAddNumberState createState() => _GroceryAddNumberState();
}

class _GroceryAddNumberState extends State<GroceryAddNumber> {
  SharedPreferences prefs;
  bool isLoading = false;
  String fname, lname, email, password;
  TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    changeStatusColor(grocery_colorPrimary);
    final signupdetails = ModalRoute.of(context).settings.arguments as Map;
    fname = signupdetails['fname'];
    lname = signupdetails['lname'];
    email = signupdetails['email'];
    password = signupdetails['password'];

    Future setUser(Data userModel) async {
      prefs = await SharedPreferences.getInstance();
      if (prefs != null) {
        prefs.clear();
      }
      await prefs.setString('id', userModel.userId);
      await prefs.setString('email', userModel.email);
      await prefs.setString('fname', userModel.firstName);
      await prefs.setString('lname', userModel.lastName);
      await prefs.setString('mobile', userModel.phoneNumber);
      await prefs.setString('password', userModel.password);
      await prefs.setString('apikey', userModel.token);
    }

    return Scaffold(
        backgroundColor: grocery_app_background,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 70),
          child: GW.title(grocery_lbl_Add_Number, grocery_colorPrimary,
              grocery_color_white, context),
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
                          offset: Offset(0.0, 0.9)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: spacing_standard),
                      text(grocery_lbl_What_your_Number,
                              fontSize: textSizeLarge, fontFamily: fontBold)
                          .paddingOnly(
                              top: spacing_standard_new,
                              left: spacing_standard_new,
                              right: spacing_standard_new),
                      text(
                        grocery_lbl_Enter_your_Mobile,
                        textColor: grocery_textColorSecondary,
                        fontSize: textSizeLargeMedium,
                      ).paddingOnly(
                          left: spacing_standard_new,
                          right: spacing_standard_new),
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  CountryCodePicker(
                                    onChanged: null,
                                  ),
                                  Icon(Icons.arrow_drop_down,
                                      size: 30,
                                      color: grocery_textColorSecondary),
                                ],
                              ),
                              Container(
                                height: 1,
                                width: width * 0.22,
                                decoration: boxDecoration(
                                    bgColor: grocery_textColorSecondary
                                        .withOpacity(0.5),
                                    radius: 10.0),
                              ).paddingOnly(left: spacing_standard_new)
                            ],
                          ),
                          Expanded(
                            child: GW.EditText(
                                    text: grocery_hint_Enter_mobile_number,
                                    isPassword: false,
                                    mController: mobileController,
                                    keyboardType: TextInputType.number)
                                .paddingOnly(
                              left: spacing_standard_new,
                              right: spacing_standard_new,
                            ),
                          )
                        ],
                      ).paddingOnly(top: spacing_standard_new),
                      SizedBox(height: spacing_standard_new),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FittedBox(
                          child: GW
                              .groceryButton(
                                textContent: grocery_lbl_Sign_Up,
                                onPressed: (() {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  var mob = mobileController.text;
                                  if (mob.isEmptyOrNull) {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text('Error'),
                                              content: Text(
                                                  'Please Enter Mobile Number'),
                                              actions: <Widget>[
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                    },
                                                    child: Text('Ok'))
                                              ],
                                            ));
                                  } else if (mob.length != 10) {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text('Error'),
                                              content: Text(
                                                  'Enter Valid Mobile Number'),
                                              actions: <Widget>[
                                                FlatButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('Ok'))
                                              ],
                                            ));
                                  } else {
                                    UserloginModel userSignup = UserloginModel(
                                        email: email,
                                        password: password,
                                        firstname: fname,
                                        lastname: lname,
                                        mobile: mob);
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .usersignup(userSignup)
                                        .then((value) {
                                      setUser(Data(
                                          userId: value.data.userId,
                                          email: email,
                                          firstName: fname,
                                          lastName: lname,
                                          phoneNumber: mob,
                                          token: value.data.token));
                                      print('object : ${Data().email}');
                                      print('email : $email');
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Fluttertoast.showToast(
                                          msg: value.message,
                                          toastLength: Toast.LENGTH_SHORT);
                                      Navigator.of(context)
                                          .pushReplacementNamed(Dashboard.Tag);
                                    });
                                  }
                                }),
                              )
                              .paddingOnly(
                                  right: spacing_standard_new,
                                  bottom: spacing_standard_new),
                        ).paddingOnly(
                            top: spacing_standard_new,
                            bottom: spacing_standard_new),
                      )
                    ],
                  ),
                ),
              ));
  }
}
