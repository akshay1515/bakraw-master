import 'package:bakraw/provider/couponsliderProvider.dart';
import 'package:bakraw/provider/flashsaleprovider.dart';
import 'package:bakraw/provider/previousorderprovider.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:bakraw/widget/bannercarousel.dart';
import 'package:bakraw/widget/couponsbanner.dart';
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
  var flashsale=0;
  var cuopon = 0;
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getUserInfo().then((value) {
      if (isLoading) {
        Provider.of<couponslideProvider>(context,listen: false).getCategory().then((value) {
          cuopon = value.data.length;
        });
        Provider.of<FlashSaleProvider>(context, listen: false)
            .getFlashSaleProduct()
            .then((value) {
          flashsale = value.data.length;
          setState(() {
            isLoading = false;
          });
        });
        if (userid != null) {
          Provider.of<PreviousOrderProvider>(context, listen: false)
              .getFlashSaleProduct(apikey, userid, email);
        }
      }
    });
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SafeArea(
            child: Scaffold(
              body: ListView(
                children: [
                  AspectRatio(aspectRatio: 3 / 2, child: BannerSlider()),
                  Container(
                    margin: EdgeInsets.only(
                        top: spacing_standard_new,
                        left: spacing_standard_new,
                        right: spacing_standard_new,
                        bottom: spacing_standard),
                    child: Container(
                        width: MediaQuery.of(context).size.width/4,
                        height: MediaQuery.of(context).size.height/35,
                        child: Image.asset('images/bannerimage/Category.png',fit: BoxFit.contain,))
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: HorizontalScrollview(),
                  ),
                  flashsale > 0
                      ? Container(
                    alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              top: spacing_standard_new,
                              left: spacing_standard_new,
                              right: spacing_standard_new,
                              bottom: spacing_standard),
                          child: Container(
                              width: MediaQuery.of(context).size.width/4,
                              height: MediaQuery.of(context).size.height/35,
                              child: Image.asset('images/bannerimage/Flash-sale.png',fit: BoxFit.contain,))
                  )
                      : Container(),
                  flashsale > 0
                      ? Container(height: 200, child: FlashSale())
                      : Container(),
                  userid != null
                      ? Container(child: PreviousOrder())
                      : Container(),
                 cuopon > 0 ? Couponsslider():Container()
                ],
              ),
            ),
          );
  }

  @override
  void initState() {

    super.initState();
  }
}
