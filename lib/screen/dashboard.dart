import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/screen/FavouriteProduct.dart';
import 'package:bakraw/screen/aboutus.dart';
import 'package:bakraw/screen/cart/mycart2.dart';
import 'package:bakraw/screen/home.dart';
import 'package:bakraw/screen/mycart.dart';
import 'package:bakraw/screen/orderhistory.dart';
import 'package:bakraw/screen/privacypolicy.dart';
import 'package:bakraw/screen/searchscreen.dart';
import 'package:bakraw/screen/termsandcondition.dart';
import 'package:bakraw/screen/useraddresslist.dart';
import 'package:bakraw/screen/userprofile.dart';
import 'package:bakraw/screen/webview.dart';
import 'package:bakraw/utils/GeoceryStrings.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:bakraw/widget/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  static String Tag = '/Dashboard';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  SharedPreferences prefs;

  List<String> listImage = [
    'images/customicons/Icon-Home.png',
    'images/customicons/Icon-My-Profile.png',
    'images/customicons/Icon-My-Addresses.png',
    'images/customicons/Icon-My-Past-Orders.png',
    'images/customicons/Icon-Terms-&-Conditions.png',
    'images/customicons/Icon-Privacy-Policy.png',
    'images/customicons/Icon-Contact-Us.png',
    'images/customicons/Icon-4About-Us.png',
  ];

  var listText = [
    'Home',
    'My Profile',
    'My Addresses',
    'My Past Orders',
    grocery_lbl_Terms_and_Condition,
    'Privacy Policy',
    'Contact Us',
    'About Us'
  ];

  var listClick = [
    Dashboard(),
    GroceryProfile(
      istab: false,
    ),
    UserAddressManager(),
    GroceryOrderHistoryScreen(),
    Terms(),
    Privacy(),
    ContentDisplay(),
    AboutUs(),
    /*GroceryTrackOrderScreen(),
    GrocerySaveCart(),
    GroceryStoreLocatorScreen(),
    GroceryTermCondition(),
    GroceryGotQuestionScreen()*/
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget mMenuOption(var icon, var value, Widget tag) {
      return Container(
        height: 50,
        child: GestureDetector(
          onTap: () {
            finish(context);
            tag.launch(context);
          },
          child: Row(
            children: <Widget>[
              Container(
                height: 40,
                width: 40,
                decoration: boxDecoration(
                    radius: 25.0, bgColor: grocery_colorPrimary_light),
                child: Image.asset(icon,height: 25,width: 25,).paddingAll(3),
              ).paddingOnly(
                  top: spacing_control,
                  left: spacing_standard,
                  bottom: spacing_control),
              text(value, fontSize: textSizeLargeMedium, fontFamily: fontMedium,textColor: grocery_color_white)
                  .paddingOnly(left: spacing_standard, right: spacing_standard),
            ],
          ),
        ),
      );
    }

    final menu = IconButton(
      icon: Icon(
        Icons.menu,
        color: grocery_color_white,
      ),
      onPressed: () {
        return showGeneralDialog(
          context: context,
          barrierDismissible: true,
          transitionDuration: Duration(milliseconds: 500),
          barrierLabel: MaterialLocalizations.of(context).dialogLabel,
          barrierColor: Colors.black.withOpacity(0.5),
          pageBuilder: (context, _, __) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: spacing_large),
                  Container(
                    alignment: Alignment.centerLeft,
                    color: grocery_colorPrimary,
                    child: Icon(Icons.clear, color: grocery_light_gray_color)
                        .onTap(() {
                      finish(context);
                    }).paddingOnly(left: 20,right: 10,top: 10,bottom: 0)
                  ),
                  Container(
                    padding: EdgeInsets.only(left: spacing_standard,bottom: spacing_large),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: grocery_colorPrimary,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                    ),
                    child: ListView.builder(
                      itemCount: listImage.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return mMenuOption(listImage[index], listText[index],
                            listClick[index]);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
          transitionBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: CurvedAnimation(
                      parent: animation, curve: Curves.easeOut)
                  .drive(
                      Tween<Offset>(begin: Offset(0, -1.0), end: Offset.zero)),
              child: child,
            );
          },
        );
      },
    );

    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: CustomAppBar(
          navigationDrawer: menu,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: grocery_color_white,
                ),
                onPressed: () {
                  SearchScreen().launch(context);
                }),
            IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: grocery_color_white,
                ),
                onPressed: () {}),
          ],
          title: 'Goatmeat',
          Tabbar: TabBar(
            indicatorColor: grocery_color_white,
            tabs: [
              Tab(
                  icon: Icon(
                Icons.storefront,
                color: grocery_color_white,
              )),
              Tab(
                  icon: Icon(
                Icons.shopping_basket_outlined,
                color: grocery_color_white,
              )),
              Tab(
                  icon: Icon(
                Icons.favorite_outline,
                color: grocery_color_white,
              )),
              Tab(
                  icon: Icon(
                Icons.account_circle_outlined,
                color: grocery_color_white,
              )),
            ],
          ),
          body: TabBarView(
            children: <Widget>[
              Home(istab: true),
              Mycart2(),
              UserFavouriteList(),
              GroceryProfile(istab: true)
            ],
          ),
        ),
      ),
    );
  }
}
