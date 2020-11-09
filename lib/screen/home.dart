import 'package:bakraw/provider/flashsaleprovider.dart';
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
  bool isinit;
  int defaultvalue = 0;
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
    return email;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      Provider.of<FlashSaleProvider>(context)
          .getFlashSaleProduct()
          .then((value) {
        if (value.data.length > 0) {
          setState(() {
            isinit == true;
          });
        }
        setState(() {
          isLoading = false;
        });
      });
    }

    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
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
                isinit
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
                isinit
                    ? Container(height: 200, child: FlashSale())
                    : Container(),
                email != null
                    ?
                Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        margin: EdgeInsets.only(
                            top: spacing_standard_new,
                            right: spacing_standard_new,
                            bottom: spacing_standard),
                        child: PreviousOrder())
                    : Container()
              ],
            ),
          );
  }

  @override
  void initState() {
    super.initState();
    if (isLoading) {
      setState(() {
        getUserInfo();
        isinit = false;
      });
    }
  }
}
