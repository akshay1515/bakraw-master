import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/usermodel.dart' as daat;
import 'package:bakraw/provider/OTPProvider.dart';
import 'package:bakraw/provider/userprovider.dart';
import 'package:bakraw/screen/dashboard.dart';
import 'package:bakraw/screen/signup.dart';
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

class VerifyNumber extends StatefulWidget {
  static String tag = '/GroceryAddNumber';
  final String mobile;

  const VerifyNumber({Key key, this.mobile}) : super(key: key);

  @override
  _VerifyNumberState createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumber> {
  SharedPreferences prefs;
  bool isLoading = false;
  TextEditingController verifyNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    changeStatusColor(grocery_colorPrimary);
    var width = MediaQuery.of(context).size.width;

    Future setUser(daat.Data userModel) async {
      prefs = await SharedPreferences.getInstance();
      if (prefs != null) {
        prefs.clear();
      }
      await prefs.setString('id', userModel.userId);
      await prefs.setString('email',userModel.email );
      await prefs.setString('fname',userModel.firstName );
      await prefs.setString('lname',userModel.lastName );
      await prefs.setString('mobile',userModel.phoneNumber );
      await prefs.setString('apikey', userModel.token);
    }

    return Scaffold(
        backgroundColor: grocery_app_background,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 70),
          child: GW.title('Verify Number', grocery_colorPrimary,
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
                text('Verify Your Number',
                    fontSize: textSizeLarge, fontFamily: fontBold)
                    .paddingOnly(
                    top: spacing_standard_new,
                    left: spacing_standard_new,
                    right: spacing_standard_new),
                text(
                  'Please Enter 6 digit Verification Code',
                  textColor: grocery_textColorSecondary,
                  fontSize: textSizeLargeMedium,
                ).paddingOnly(
                    left: spacing_standard_new,
                    right: spacing_standard_new),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: GW.EditText(
                          text: grocery_hint_Verify_Number,
                          isPassword: false,
                          mController: verifyNumber,
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
                      bgColors: grocery_colorPrimary,
                      textContent: 'Verify',
                      onPressed: (() {
                        setState(() {
                          isLoading = true;
                        });
                        var mob = verifyNumber.text;
                        if (mob.isEmptyOrNull) {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Error'),
                                content: Text(
                                    'Please Enter OTP'),
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
                        }
                        else {
                          Provider.of<OTPProvider>(context,listen: false).VerifyOTP(widget.mobile, mob).then((value){
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Status'),
                                  content: Text(
                                      value.message),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop();
                                          if(value.data.isNewUser){
                                            SignUp(Mobile: widget.mobile,).launch(context);
                                          }else{
                                            setUser(daat.Data(
                                              userId: value.data.userId,
                                              email: value.data.email,
                                              firstName: value.data.firstName,
                                              lastName: value.data.lastName,
                                              token: value.data.token,
                                              phoneNumber: value.data.phoneNumber
                                            )).then((value){
                                              Navigator.of(context).pushReplacementNamed(Dashboard.Tag);
                                            });
                                          }
                                          setState(() {
                                            isLoading = false;
                                          });
                                        },
                                        child: Text('Ok'))
                                  ],
                                ));
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
