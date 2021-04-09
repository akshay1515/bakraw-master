import 'package:bakraw/provider/categoryprovider.dart';
import 'package:bakraw/screen/aboutus.dart';
import 'package:bakraw/screen/newui/newhomepage.dart';
import 'package:bakraw/screen/orderhistory.dart';
import 'package:bakraw/screen/privacypolicy.dart';
import 'package:bakraw/screen/termsandcondition.dart';
import 'package:bakraw/screen/useraddresslist.dart';
import 'package:bakraw/screen/webview.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewDashboard extends StatefulWidget {
  @override
  _NewDashboardState createState() => _NewDashboardState();
}

class _NewDashboardState extends State<NewDashboard> {
  int isSelected = 0;
  bool isLoading = true;
  var navigtab = null;

  @override
  void initState() {}

  Widget selectedPage() {}

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
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
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
