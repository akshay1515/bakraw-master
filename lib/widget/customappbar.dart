import 'package:bakraw/screen/aboutus.dart';
import 'package:bakraw/screen/newui/newhomepage.dart';
import 'package:bakraw/screen/newui/newuserprofile.dart';
import 'package:bakraw/screen/orderhistory.dart';
import 'package:bakraw/screen/privacypolicy.dart';
import 'package:bakraw/screen/termsandcondition.dart';
import 'package:bakraw/screen/useraddresslist.dart';
import 'package:bakraw/screen/webview.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppbar extends StatelessWidget with PreferredSizeWidget {
  String userid = '',
      email = '',
      apikey = '',
      fname = '',
      lname = '',
      mobile = '';

  Future<String> getUserInfo() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      email = prefs.getString('email');
      apikey = prefs.getString('apikey');
      userid = prefs.getString('id');
      fname = prefs.getString('fname');
      lname = prefs.getString('lname');
      mobile = prefs.getString('mobile');
    }
    return userid;
  }

  @override
  final Size preferredSize;

  CustomAppbar({
    Key key,
  })  : preferredSize = Size.fromHeight(50),
        super(key: key);

  List<String> drawerimageList = [
    'images/customicons/Icon-Home.png',
    'images/customicons/Icon-My-Profile.png',
    'images/customicons/Icon-My-Addresses.png',
    'images/customicons/Icon-My-Past-Orders.png',
    'images/customicons/Icon-Terms-&-Conditions.png',
    'images/customicons/Icon-Privacy-Policy.png',
    'images/customicons/Icon-Contact-Us.png',
    'images/customicons/Icon-4About-Us.png',
  ];
  List<String> menuString = [
    'Home',
    'My Profile',
    'My Addresses',
    'My Past Orders',
    'Terms & Condtions',
    'Privacy Policy',
    'Contact Us',
    'About Us'
  ];

  List<String> onclick = [
    NewHomepage.Tag,
    NewUserProfile.Tag,
    UserAddressManager.tag,
    GroceryOrderHistoryScreen.tag,
    Terms.tag,
    Privacy.tag,
    ContentDisplay.tag,
    AboutUs.tag
  ];
  List<Map> argumentsparam = [
    {'id': 0},
    {'id': 4},
    {'isnav': false},
    {'id': "8"},
    {'id': '0'},
    {'id': '0'},
    {'id': '0'},
    {'id': '0'}
  ];

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
          onPressed: () {
            return showGeneralDialog(
                context: context,
                barrierDismissible: true,
                transitionDuration: Duration(milliseconds: 300),
                barrierLabel: MaterialLocalizations.of(context).dialogLabel,
                barrierColor: Colors.black.withOpacity(0.5),
                pageBuilder: (context, _, __) {
                  return Wrap(
                    children: [
                      Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              SizedBox(height: 24),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  color: grocery_colorPrimary,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 10),
                                    child: Row(
                                      children: [
                                        IconButton(
                                            icon: Icon(Icons.clear,
                                                color: Colors.white),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            }),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4.0,
                                              right: 8,
                                              top: 8,
                                              bottom: 10),
                                          child: Image.asset(
                                            'images/Bakraw.png',
                                            height: 35,
                                            width: 35,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            'Bakraw',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                              Container(
                                transform: Matrix4.translationValues(0, -10, 0),
                                padding: EdgeInsets.only(left: 8, bottom: 20),
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: grocery_colorPrimary,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20)),
                                ),
                                child: ListView.builder(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  itemCount: drawerimageList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 50,
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pushNamed(
                                              onclick[index],
                                              arguments: argumentsparam[index],
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8, bottom: 4),
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    padding: EdgeInsets.all(3),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                        color:
                                                            grocery_colorPrimary_light),
                                                    child: Image.asset(
                                                      drawerimageList[index],
                                                      height: 25,
                                                      width: 25,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  )),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8),
                                                child: Text(
                                                  menuString[index],
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          )),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
                transitionBuilder: (context, animation, secondary, child) {
                  return SlideTransition(
                    position: CurvedAnimation(
                            parent: animation, curve: Curves.easeOut)
                        .drive(Tween<Offset>(
                            begin: Offset(0, -1), end: Offset.zero)),
                    child: child,
                  );
                });
          },
          icon: ImageIcon(
            AssetImage('images/newicons/notification.png'),
            color: grocery_colorPrimary,
            size: 20,
          )),
      title: Container(
        margin: EdgeInsets.only(left: 15),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(NewHomepage.Tag);
          },
          child: Center(
              child: Image.asset(
            'images/Bakraw.png',
            height: 40,
            width: 40,
            fit: BoxFit.contain,
          )),
        ),
      ),
      actions: [
        IconButton(
            icon: Icon(
              Icons.notifications,
              color: grocery_colorPrimary,
              size: 35,
            ),
            onPressed: () {
              Fluttertoast.showToast(
                  msg: 'This feature will be avaliable soon',
                  toastLength: Toast.LENGTH_SHORT,
                  textColor: Colors.white,
                  backgroundColor: Colors.black.withOpacity(0.7),
                  gravity: ToastGravity.SNACKBAR);
            }),
        Container(
          height: 30,
          width: 30,
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
              color: grocery_colorPrimary, shape: BoxShape.circle),
          child: IconButton(
              icon: ImageIcon(
                AssetImage('images/newicons/userprofile.png'),
                color: grocery_color_white,
                size: 25,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(NewUserProfile.Tag);
              }),
        ),
      ],
    );
  }
}
