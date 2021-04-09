import 'package:bakraw/screen/FavouriteProduct.dart';
import 'package:bakraw/screen/newui/newhomepage.dart';
import 'package:bakraw/screen/newui/newsignup.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/widget/bakrawproperties.dart';
import 'package:bakraw/widget/bottomnavigationbar.dart';
import 'package:bakraw/widget/customappbar.dart';
import 'package:bakraw/widget/horizontallist.dart';
import 'package:bakraw/widget/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewFavourite extends StatefulWidget {
  static const Tag = '/UserFavourite';

  @override
  _NewFavouriteState createState() => _NewFavouriteState();
}

class _NewFavouriteState extends State<NewFavourite> {
  String userid = '', email = '', apikey = '';
  bool favinit = false;

  @override
  void initState() {
    setUser().then((value) {
      setState(() {
        favinit = true;
      });
    });
  }

  Widget usercheck() {
    Future.delayed(Duration(seconds: 0), () {
      Navigator.popAndPushNamed(context, NewLogin.Tag);
    });
    return Container();
  }

  Future<String> setUser() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      email = prefs.getString('email');
      userid = prefs.getString('id');
      apikey = prefs.getString('apikey');
      return userid;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: CustomAppbar(),
          body: favinit
              ? userid != null
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                              child: Stack(
                            children: [
                              Column(
                                children: [
                                  Container(
                                      height: 220,
                                      width: double.infinity,
                                      color: Color.fromRGBO(51, 105, 30, 1)),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    margin: EdgeInsets.only(top: 50),
                                    height: 55,
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              top: BorderSide(
                                                  style: BorderStyle.solid,
                                                  color:
                                                      grocery_colorPrimary_light,
                                                  width: 3))),
                                      margin: EdgeInsets.only(top: 10),
                                      padding: EdgeInsets.only(top: 10),
                                      child: HorizontalScrollview())
                                ],
                              ),
                              Container(child: BakrawUniqueness()),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Searchbar(topmargin: 190),
                                  Center(child: UserFavouriteList())
                                ],
                              ),
                            ],
                          )),
                          BottomNav(currentScreen: 2)
                        ],
                      ),
                    )
                  : usercheck()
              : Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ),
        onWillPop: () {
          return Navigator.of(context)
              .pushReplacementNamed(NewHomepage.Tag, arguments: {'id': 0});
        });
  }
}
