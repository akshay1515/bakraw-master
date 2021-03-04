import 'package:bakraw/provider/categoryprovider.dart';
import 'package:bakraw/screen/aboutus.dart';
import 'package:bakraw/screen/cart/mycart2.dart';
import 'package:bakraw/screen/newui/newcategory.dart';
import 'package:bakraw/screen/newui/newfavourite.dart';
import 'package:bakraw/screen/newui/newhomepage.dart';
import 'package:bakraw/screen/newui/newsignup.dart';
import 'package:bakraw/screen/newui/newuserprofile.dart';
import 'package:bakraw/screen/orderhistory.dart';
import 'package:bakraw/screen/privacypolicy.dart';
import 'package:bakraw/screen/termsandcondition.dart';
import 'package:bakraw/screen/useraddresslist.dart';
import 'package:bakraw/screen/webview.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewDashboard extends StatefulWidget {
  @override
  _NewDashboardState createState() => _NewDashboardState();
}

class _NewDashboardState extends State<NewDashboard> {
  int isSelected = 0;
  bool isLoading = true;
  var navigtab = null;

  String userid = '',
      email = '',
      apikey = '',
      fname = '',
      lname = '',
      mobile = '';

  @override
  void initState() {}

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

  Widget selectedPage() {
    if (isSelected < 1) {
      return NewHomepage();
    } else if (isSelected == 1) {
      return Mycart2();
    } else if (isSelected == 2) {
      return NewFavourite();
    } else if (isSelected == 3) {
      return NewCategory();
    } else if (isSelected == 4) {
      if (userid == null || userid.isEmpty) {
        return NewLogin();
      } else {
        return NewUserProfile();
      }
    } else {
      return NewHomepage();
    }
  }

  List<String> imageList = [
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
    NewHomepage.Tag,
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
    getUserInfo();
    navigtab = ModalRoute.of(context).settings.arguments as Map;
    if (isLoading) {
      int Categoryid = Provider.of<CategoryProvider>(context).selectedid;
      String selected = Provider.of<CategoryProvider>(context).categoryid;
      if (selected.isNotEmpty || selected != null) {
        setState(() {
          isSelected = Categoryid;
        });
      }
      isLoading = false;
    }

    if (navigtab != null) {
      setState(() {
        isSelected = navigtab['id'];
      });
    }

    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  SizedBox(height: 24),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      color: grocery_colorPrimary,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 10, top: 10),
                                        child: IconButton(
                                            icon: Icon(Icons.clear,
                                                color:
                                                    grocery_light_gray_color),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            }),
                                      )),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 8, bottom: 20),
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(
                                      color: grocery_colorPrimary,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20)),
                                    ),
                                    child: ListView.builder(
                                      itemCount: imageList.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height: 50,
                                          child: GestureDetector(
                                              onTap: () {
                                                if(isSelected != index) {
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                      onclick[index],
                                                      arguments:
                                                      argumentsparam[index]);
                                                }
                                              },
                                              child: Row(
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8, bottom: 4),
                                                      child: Container(
                                                        height: 40,
                                                        width: 40,
                                                        padding:
                                                            EdgeInsets.all(3),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                            color:
                                                                grocery_colorPrimary_light),
                                                        child: Image.asset(
                                                          imageList[index],
                                                          height: 25,
                                                          width: 25,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      )),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
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
                if (isSelected != 0) {
                  Navigator.of(context)
                      .pushNamed(NewHomepage.Tag, arguments: {'id': 0});
                }
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
                ),
                onPressed: () {}),
            Container(
              height: 30,
              width: 30,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: grocery_colorPrimary, shape: BoxShape.circle),
              child: IconButton(
                  icon: ImageIcon(
                    AssetImage('images/newicons/userprofile.png'),
                    color: isSelected != 4
                        ? grocery_color_white
                        : grocery_colorPrimary_light,
                    size: 15,
                  ),
                  onPressed: () {
                    if (isSelected != 4) {
                      Navigator.of(context)
                          .pushNamed(NewHomepage.Tag, arguments: {'id': 4});
                    }
                  }),
            ),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              selectedPage(),
              //---------------------------Bottom Navigation Bar-------------------------------------
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                  width: size.width,
                  height: 80,
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size(size.width, 80),
                        painter: BakrawPainter(),
                      ),
                      Center(
                        heightFactor: 0.5,
                        child: Container(
                          height: size.width * 0.17,
                          width: size.width * 0.20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 1, right: 1, bottom: 1, top: 1),
                            child: FloatingActionButton(
                              elevation: 2,
                              backgroundColor: isSelected == 0
                                  ? grocery_colorPrimary_light
                                  : Colors.white,
                              onPressed: () {
                                if (isSelected != 0) {
                                  Provider.of<CategoryProvider>(context,
                                          listen: false)
                                      .ChangeCategory('', 0);
                                  Navigator.of(context).pushNamed(
                                      NewHomepage.Tag,
                                      arguments: {'id': 0});
                                }
                              },
                              child: ImageIcon(
                                AssetImage(isSelected != 0
                                    ? 'images/newicons/shopwhite.png'
                                    : 'images/newicons/shopcolor.png'),
                                size: 25,
                                color: isSelected != 0
                                    ? grocery_colorPrimary_light
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 50, right: 50, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                                child: IconButton(
                                    icon: isSelected != 1
                                        ? ImageIcon(
                                            AssetImage(
                                                'images/newicons/cartoutline.png'),
                                            size: 25,
                                          )
                                        : ImageIcon(
                                            AssetImage(
                                                'images/newicons/cartcolor.png'),
                                            size: 25,
                                            color: grocery_colorPrimary,
                                          ),
                                    onPressed: () {
                                      if (isSelected != 1) {
                                        Provider.of<CategoryProvider>(context,
                                                listen: false)
                                            .ChangeCategory('', 1);
                                        Navigator.of(context).pushNamed(
                                            NewHomepage.Tag,
                                            arguments: {'id': 1});
                                      }
                                    })),
                            Center(
                                child: IconButton(
                                    icon: isSelected != 2
                                        ? ImageIcon(
                                            AssetImage(
                                                'images/newicons/favouriteoutline.png'),
                                            size: 25,
                                          )
                                        : ImageIcon(
                                            AssetImage(
                                                'images/newicons/favouritecolor.png'),
                                            size: 25,
                                            color: grocery_colorPrimary,
                                          ),
                                    onPressed: () {
                                      if (isSelected != 2) {
                                        Provider.of<CategoryProvider>(context,
                                                listen: false)
                                            .ChangeCategory('', 2);
                                        Navigator.of(context).pushNamed(
                                            NewHomepage.Tag,
                                            arguments: {'id': 2});
                                      }
                                    })),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BakrawPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blueGrey.shade100
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(0, 10, 0, 10);
    path.quadraticBezierTo(size.width * 0.4, 10, size.width * 0.4, 10);
    path.arcToPoint(Offset(size.width * 0.6, 20),
        radius: Radius.circular(15.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.6, 10, size.width * 0.6, 10);
    path.quadraticBezierTo(size.width * 0.8, 10, size.width, 10);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
