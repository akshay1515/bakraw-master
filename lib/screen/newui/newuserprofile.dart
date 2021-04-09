import 'dart:ui';

import 'package:bakraw/screen/newui/newhomepage.dart';
import 'package:bakraw/screen/newui/newsignup.dart';
import 'package:bakraw/screen/useraddresslist.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/widget/bottomnavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewUserProfile extends StatefulWidget {
  static const Tag = '/NewUserProfile';

  @override
  _NewUserProfileState createState() => _NewUserProfileState();
}

class _NewUserProfileState extends State<NewUserProfile> {
  String userid = '',
      email = '',
      apikey = '',
      fname = '',
      lname = '',
      mobile = '';
  bool isinit = false;
  bool _keyVisible;

  Future<String> getUserInfo() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      setState(() {
        email = prefs.getString('email');
        apikey = prefs.getString('apikey');
        userid = prefs.getString('id');
        fname = prefs.getString('fname');
        lname = prefs.getString('lname');
        mobile = prefs.getString('mobile');
      });
    }
    return userid;
  }

  showLogoutBottomSheetDialog(context) async {
    Future UserLogout() async {
      SharedPreferences prefs;
      prefs = await SharedPreferences.getInstance();
      if (prefs != null) {
        setState(() {
          prefs.clear();
        });
      }
    }

    var w = MediaQuery.of(context).size.width;

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          width: w,
          height: 200,
          decoration: BoxDecoration(
            color: grocery_color_white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: const Radius.circular(20.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: grocery_ShadowColor,
                  blurRadius: 20.0,
                  offset: Offset(0.0, 0.9))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Container(
                          height: 50,
                          width: 50,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: grocery_colorPrimary),
                          child: Image.asset(
                            'images/newicons/logout.png',
                            height: 10,
                            width: 10,
                            color: Colors.white,
                          )),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 8, right: 8, bottom: 3),
                            child: Text('Logout',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Are you sure you want to logout ?',
                              style: TextStyle(
                                  color: Colors.grey.shade400, fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        width: w * 0.15,
                        child: Text(
                          "No",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FittedBox(
                      child: TextButton(
                        child: Container(
                          height: 40,
                          width: 125,
                          decoration: BoxDecoration(
                              color: Colors.red.shade500,
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          child: Text(
                            'Logout',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        onPressed: (() {
                          UserLogout().then((value) {
                            Navigator.of(context)
                                .pushReplacementNamed(NewHomepage.Tag);
                          });
                        }),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget navigated() {
    Future.delayed(Duration.zero, () async {
      Navigator.popAndPushNamed(context, NewLogin.Tag);
    });
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return isinit
        ? userid != null
            ? Scaffold(
                appBar: AppBar(
                  title: Text('My Profile'),
                ),
                body: WillPopScope(
                    child: SingleChildScrollView(
                      child: Container(
                        color: Colors.green.shade50,
                        height: MediaQuery.of(context).size.height,
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
                              margin: EdgeInsets.only(
                                  top: 225, left: 30, right: 10),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            '${fname}${' '}${lname}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Text('+91 ${mobile}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height - 350,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(top: 300),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(50)),
                                color: Colors.green.shade50,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          UserAddressManager.tag,
                                          arguments: {'isnav': false});
                                    },
                                    child: Card(
                                      margin: EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 50,
                                          bottom: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Container(
                                        height: 115,
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 80,
                                              width: 80,
                                              padding: EdgeInsets.all(13),
                                              decoration: BoxDecoration(
                                                  color: Colors.green.shade900,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: Image.asset(
                                                'images/newicons/addressicons.png',
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                'Delivery Address',
                                                style: TextStyle(
                                                    color: grocery_colorPrimary,
                                                    fontSize: 21),
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: grocery_colorPrimary,
                                              size: 20,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showLogoutBottomSheetDialog(context);
                                    },
                                    child: Card(
                                      margin: EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 10,
                                          bottom: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Container(
                                        height: 115,
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 80,
                                              width: 80,
                                              padding: EdgeInsets.all(22),
                                              decoration: BoxDecoration(
                                                  color: Colors.green.shade900,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: Image.asset(
                                                'images/newicons/logout.png',
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Logout',
                                                style: TextStyle(
                                                    color: grocery_colorPrimary,
                                                    fontSize: 21),
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: grocery_colorPrimary,
                                              size: 20,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            BottomNav(currentScreen: 5)
                          ],
                        ),
                      ),
                    ),
                    onWillPop: () {
                      Navigator.of(context).pushReplacementNamed(
                          NewHomepage.Tag,
                          arguments: {'id': 0});
                    }),
              )
            : navigated()
        : Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  @override
  void initState() {
    getUserInfo().then((value) {
      setState(() {
        isinit = true;
      });
    });
  }
}
