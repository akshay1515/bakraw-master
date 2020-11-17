import 'package:bakraw/provider/flashsaleprovider.dart';
import 'package:bakraw/provider/previousorderprovider.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:bakraw/widget/bannercarousel.dart';
import 'package:bakraw/widget/flashsaleitem.dart';
import 'package:bakraw/widget/horizontallist.dart';
import 'package:bakraw/widget/previousorderscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  bool istab = false;

  Home({this.istab});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  bool isinit = false;
  int defaultvalue = 0;
  var flashsale;
  String userid = '', email = 'sample', apikey = '';

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
    return 'something';
  }

  @override
  Widget build(BuildContext context) {
    getUserInfo();
    if (isLoading) {
      Provider.of<FlashSaleProvider>(context, listen: false)
          .getFlashSaleProduct()
          .then((value) {
        flashsale = value.data.length;
        if (email != null) {
          Provider.of<PreviousOrderProvider>(context, listen: false)
              .getFlashSaleProduct(apikey, userid, email)
              .then((value) {
            setState(() {
              isLoading = false;
            });
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      });
    }
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SafeArea(
            child: Scaffold(
              body: ListView(
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 3.3,
                      child: BannerSlider()),
                  Container(
                    margin: EdgeInsets.only(
                        top: spacing_standard_new,
                        left: spacing_standard_new,
                        right: spacing_standard_new,
                        bottom: spacing_standard),
                    child: Text(
                      'Category',
                      style: TextStyle(
                          fontFamily: fontMedium,
                          fontSize: textSizeLargeMedium,
                          color: Colors.grey.shade700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: HorizontalScrollview(),
                  ),
                  flashsale > 0
                      ? Container(
                          margin: EdgeInsets.only(
                              top: spacing_standard_new,
                              left: spacing_standard_new,
                              right: spacing_standard_new,
                              bottom: spacing_standard),
                          child: Text(
                            'Flash Sale',
                            style: TextStyle(
                                fontFamily: fontMedium,
                                fontSize: textSizeLargeMedium,
                                color: Colors.grey.shade700),
                          ))
                      : Container(),
                  flashsale > 0
                      ? Container(height: 200, child: FlashSale())
                      : Container(),
                  email != null
                      ? Container(child: PreviousOrder())
                      : Container()
                ],
              ),
            ),
          );
  }

  @override
  void initState() {
    super.initState();
    if (isLoading) {
      setState(() {});
    }
  }
}
