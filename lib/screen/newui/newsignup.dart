import 'package:bakraw/model/usermodel.dart' as daat;
import 'package:bakraw/provider/OTPProvider.dart';
import 'package:bakraw/provider/userprovider.dart';
import 'package:bakraw/screen/newui/newhomepage.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/widget/bottomnavigationbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewLogin extends StatefulWidget {
  static const Tag = '/NewSignup';

  @override
  _NewLoginState createState() => _NewLoginState();
}

String status = '';
int count = 0;
SharedPreferences prefs;
bool showLoading = false;
bool isOTPScreen = false;
bool isNewUser = false;
GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();

Future<String> setUser(daat.Data userModel) async {
  prefs = await SharedPreferences.getInstance();
  if (prefs != null) {
    prefs.clear();
  }
  await prefs.setString('id', userModel.userId);
  await prefs.setString('email', userModel.email);
  await prefs.setString('fname', userModel.firstName);
  await prefs.setString('lname', userModel.lastName);
  await prefs.setString('mobile', userModel.phoneNumber);
  await prefs.setString('apikey', userModel.token);

  return await prefs.getString('id');
}

bool showMobile() {
  if (!isOTPScreen && !isNewUser) {
    return true;
  } else {
    return false;
  }
}

bool showOTP() {
  if (isOTPScreen && !isNewUser) {
    return true;
  } else {
    return false;
  }
}

bool showSignup() {
  if (!isOTPScreen && isNewUser) {
    return true;
  } else {
    return false;
  }
}

class _NewLoginState extends State<NewLogin> {
  TextEditingController mobile = TextEditingController();
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController OTPController = TextEditingController();

  final _mobileValuekey = GlobalKey<FormFieldState>();
  final _fnameValuekey = GlobalKey<FormFieldState>();
  final _lnameValuekey = GlobalKey<FormFieldState>();
  final _emailValuekey = GlobalKey<FormFieldState>();

  void verifyNumber(BuildContext ctx, String mobile) {
    Provider.of<OTPProvider>(ctx, listen: false).sendOTP(mobile).then((value) {
      final snackbar = SnackBar(
        content: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 3, bottom: 3),
          child: Text(
            value.message,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: grocery_colorPrimary,
        padding: EdgeInsets.only(top: 5, bottom: 5),
      );
      _scaffoldkey.currentState.showSnackBar(snackbar).closed.then((value) {
        setState(() {
          showLoading = false;
          isOTPScreen = true;
        });
      });
    });
  }

  bool verifyOTP(String OTP, String Mobile, BuildContext ctx) {
    Provider.of<OTPProvider>(context, listen: false)
        .VerifyOTP(Mobile, OTP)
        .then((value) {
      if (value.status == 200) {
        if (value.data.isNewUser == false) {
          setUser(daat.Data(
              userId: value.data.userId,
              email: value.data.email,
              firstName: value.data.firstName,
              lastName: value.data.lastName,
              token: value.data.token,
              phoneNumber: value.data.phoneNumber));
          isOTPScreen = false;
          setState(() {
            showLoading = false;
          });
          Navigator.pushNamedAndRemoveUntil(
                  ctx, NewHomepage.Tag, (route) => false, arguments: {'id': 0})
              .then((value) => dispose());
        } else {
          setState(() {
            isOTPScreen = false;
            isNewUser = true;
          });
        }
      } else {
        count++;
        if (count < 3) {
          final snackbar = SnackBar(
            content: Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 3, bottom: 3),
              child: Text(
                value.message,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            backgroundColor: grocery_colorPrimary,
            padding: EdgeInsets.only(top: 5, bottom: 5),
          );
          _scaffoldkey.currentState.showSnackBar(snackbar).closed.then((value) {
            setState(() {
              showLoading = false;
            });
          });
        } else {
          count = 0;
          setState(() {
            isOTPScreen = false;
            isNewUser = false;
          });
        }
      }
      setState(() {
        showLoading = false;
      });
    });
  }

  void usrSignUp(
      {String varfname,
      String varlname,
      String varemail,
      String varmobile,
      BuildContext ctx}) {
    Provider.of<UserProvider>(context, listen: false)
        .usersignup(daat.Data(
      phoneNumber: varmobile,
      firstName: varfname,
      lastName: varlname,
      email: varemail,
    ))
        .then((value) {
      if (value.status == 200) {
        setUser(daat.Data(
                email: varemail,
                firstName: varfname,
                lastName: varlname,
                phoneNumber: varmobile,
                userId: value.data.userId,
                token: value.data.token))
            .then((value) {
          setState(() {
            showLoading = false;
          });
          Navigator.pushNamedAndRemoveUntil(
                  ctx, NewHomepage.Tag, (route) => false, arguments: {'id': 0})
              .then((value) => dispose());
        });
      } else {
        final snackbar = SnackBar(
          content: Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 3, bottom: 3),
            child: Text(
              value.message,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: grocery_colorPrimary,
          padding: const EdgeInsets.only(top: 3, bottom: 3),
        );
        _scaffoldkey.currentState.showSnackBar(snackbar).closed.then((value) {
          setState(() {
            showLoading = false;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: WillPopScope(
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        color: grocery_colorPrimary,
                        child: Container(
                          height: 350,
                          child: Image.asset('images/bgimage.png',
                              fit: BoxFit.fitHeight),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 150),
                        alignment: Alignment.center,
                        child: Image.asset(
                          'images/Bakraw.png',
                          fit: BoxFit.fill,
                          width: 125,
                          height: 125,
                        ),
                      ),
                      Visibility(
                        visible: showMobile(),
                        child: Container(
                          height: 500,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(
                            top: 300,
                          ),
                          padding: EdgeInsets.only(top: 45, bottom: 50),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50)),
                            color: Color.fromRGBO(152, 158, 52, 1),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'What\'s your Number',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Enter Mobile Number to Continue',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 40),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 115,
                                      height: 50,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'images/newicons/indianflag.png',
                                            width: 25,
                                            height: 25,
                                            fit: BoxFit.fill,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0),
                                            child: Text(
                                              'IN +91',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17),
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down_outlined,
                                            color: Colors.grey.shade500,
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.75,
                                      child: TextFormField(
                                        key: _mobileValuekey,
                                        controller: mobile,
                                        textInputAction: TextInputAction.done,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        textAlign: TextAlign.start,
                                        onFieldSubmitted: (value) {
                                          if (_mobileValuekey.currentState
                                              .validate()) {
                                            setState(() {
                                              showLoading = true;
                                            });
                                            verifyNumber(context, mobile.text);
                                          }
                                        },
                                        validator: (value) {
                                          if (value.length != 10) {
                                            return '${'\u{26A0}'} valid mobile number is required';
                                          } else if (value.trim().isEmpty) {
                                            return '${'\u{26A0}'} Enter Mobile Number';
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            contentPadding: EdgeInsets.only(
                                                left: 15, top: 6),
                                            errorStyle: TextStyle(height: 0.5),
                                            hintText: 'Your Mobile Number',
                                            filled: true,
                                            fillColor: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              TextButton(
                                child: Container(
                                  height: 50,
                                  width: 125,
                                  margin: EdgeInsets.only(top: 15),
                                  decoration: BoxDecoration(
                                      color: grocery_colorPrimary,
                                      borderRadius: BorderRadius.circular(50)),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Send OTP'.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                onPressed: (() {
                                  if (_mobileValuekey.currentState.validate()) {
                                    setState(() {
                                      showLoading = true;
                                    });
                                    verifyNumber(context, mobile.text);
                                  }
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: showOTP(),
                        child: Container(
                          height: MediaQuery.of(context).size.height - 400,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(top: 300),
                          padding: EdgeInsets.only(top: 45),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50)),
                            color: Color.fromRGBO(152, 158, 52, 1),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Verify Your Number',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Please enter 6 digit OTP Verification Code',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 40),
                                  padding: EdgeInsets.only(left: 8, right: 8),
                                  child: PinCodeTextField(
                                    enableActiveFill: true,
                                    backgroundColor: Colors.transparent,
                                    appContext: context,
                                    length: 6,
                                    pastedTextStyle: TextStyle(
                                      color: Colors.green.shade600,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    pinTheme: PinTheme(
                                        shape: PinCodeFieldShape.box,
                                        borderRadius: BorderRadius.circular(20),
                                        activeFillColor: Colors.white,
                                        activeColor: Colors.white,
                                        fieldHeight: 45,
                                        fieldWidth: 60,
                                        selectedColor: Colors.white,
                                        disabledColor: Colors.white,
                                        inactiveColor: Colors.white,
                                        inactiveFillColor: Colors.white,
                                        selectedFillColor: Colors.white),
                                    onChanged: (String value) {},
                                    onCompleted: (value) {
                                      setState(() {
                                        showLoading = true;
                                      });
                                      verifyOTP(value, mobile.text, context);
                                    },
                                    keyboardType: TextInputType.number,
                                  )),
                              TextButton(
                                child: Container(
                                  height: 50,
                                  width: 125,
                                  margin: EdgeInsets.only(top: 15),
                                  /* decoration: BoxDecoration(
                            color: grocery_colorPrimary,
                            borderRadius: BorderRadius.circular(50)
                        ),*/
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Resend OTP',
                                    style: TextStyle(
                                        color: grocery_colorPrimary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                                onPressed: (() {
                                  setState(() {
                                    isOTPScreen = false;
                                  });
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: showSignup(),
                        child: Container(
                          height: MediaQuery.of(context).size.height - 250,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(top: 300),
                          padding: EdgeInsets.only(top: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50)),
                            color: Color.fromRGBO(152, 158, 52, 1),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Enter Your Details',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Fill Your Information',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  padding: EdgeInsets.only(left: 8, right: 8),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(
                                            left: 10, bottom: 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Enter Your First Name',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 1),
                                              child: Text(
                                                '*',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextFormField(
                                          key: _fnameValuekey,
                                          controller: fname,
                                          textInputAction: TextInputAction.done,
                                          keyboardType: TextInputType.name,
                                          textAlign: TextAlign.start,
                                          onFieldSubmitted: (value) {},
                                          validator: (value) {
                                            if (value.length < 1) {
                                              return '${'\u{26A0}'} Firstname is required';
                                            } else if (value.trim().isEmpty) {
                                              return '${'\u{26A0}'} Firstname is required';
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, top: 6),
                                              errorStyle:
                                                  TextStyle(height: 0.5),
                                              hintText: 'e.g. Akshay',
                                              filled: true,
                                              fillColor: Colors.white),
                                        ),
                                      )
                                    ],
                                  )),
                              Container(
                                  padding: EdgeInsets.only(left: 8, right: 8),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(
                                            left: 10, bottom: 5, top: 8),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Enter Your Last Name',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 1),
                                              child: Text(
                                                '*',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextFormField(
                                          key: _lnameValuekey,
                                          controller: lname,
                                          textInputAction: TextInputAction.done,
                                          keyboardType: TextInputType.name,
                                          textAlign: TextAlign.start,
                                          onFieldSubmitted: (value) {},
                                          validator: (value) {
                                            if (value.length < 1) {
                                              return '${'\u{26A0}'} lastname is required';
                                            } else if (value.trim().isEmpty) {
                                              return '${'\u{26A0}'} lastname is required';
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, top: 6),
                                              errorStyle:
                                                  TextStyle(height: 0.5),
                                              hintText: 'e.g. Rathi',
                                              filled: true,
                                              fillColor: Colors.white),
                                        ),
                                      )
                                    ],
                                  )),
                              Container(
                                  padding: EdgeInsets.only(left: 8, right: 8),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(
                                            left: 10, bottom: 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Enter Your Email id',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 1),
                                              child: Text(
                                                '*',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextFormField(
                                          key: _emailValuekey,
                                          controller: email,
                                          textInputAction: TextInputAction.done,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          textAlign: TextAlign.start,
                                          onFieldSubmitted: (value) {},
                                          validator: (value) {
                                            if (value.length < 1) {
                                              return '${'\u{26A0}'} Email is required';
                                            } else if (value.trim().isEmpty) {
                                              return '${'\u{26A0}'} Email is required';
                                            } else if (!EmailValidator.validate(
                                                value)) {
                                              return '${'\u{26A0}'} Enter Valid Email';
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, top: 6),
                                              errorStyle:
                                                  TextStyle(height: 0.5),
                                              hintText:
                                                  'e.g. example@youmail.com',
                                              filled: true,
                                              fillColor: Colors.white),
                                        ),
                                      )
                                    ],
                                  )),
                              TextButton(
                                child: Container(
                                  height: 50,
                                  width: 125,
                                  margin: EdgeInsets.only(top: 15),
                                  decoration: BoxDecoration(
                                      color: grocery_colorPrimary,
                                      borderRadius: BorderRadius.circular(50)),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                onPressed: (() {
                                  if (_emailValuekey.currentState.validate() &&
                                      _fnameValuekey.currentState.validate() &&
                                      _lnameValuekey.currentState.validate()) {
                                    setState(() {
                                      showLoading = true;
                                    });
                                    usrSignUp(
                                        ctx: context,
                                        varemail: email.text,
                                        varfname: fname.text,
                                        varlname: lname.text,
                                        varmobile: mobile.text);
                                  }
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            color: Colors.black45,
                            child: Center(
                              child: CircularProgressIndicator(),
                            )),
                        visible: showLoading,
                      ),
                    ],
                  ),
                ),
                onWillPop: () {
                  if (isNewUser) {
                    mobile.clear();
                    OTPController.clear();
                    fname.clear();
                    lname.clear();
                    email.clear();
                    setState(() {
                      isNewUser = false;
                      isOTPScreen = false;
                    });
                  } else if (isOTPScreen) {
                    mobile.clear();
                    OTPController.clear();
                    fname.clear();
                    lname.clear();
                    email.clear();
                    setState(() {
                      isNewUser = false;
                      isOTPScreen = false;
                    });
                  } else {
                    Navigator.of(context).pushReplacementNamed(NewHomepage.Tag,
                        arguments: {'id': 0}).then((value) => dispose());
                  }
                  return null;
                }),
          ),
          BottomNav(currentScreen: 5)
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
