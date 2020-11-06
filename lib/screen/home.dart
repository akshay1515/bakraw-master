import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:bakraw/widget/bannercarousel.dart';
import 'package:bakraw/widget/flashsaleitem.dart';
import 'package:bakraw/widget/horizontallist.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  bool istab = false;
  Home({this.istab});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return widget.istab
        ? ListView(
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
              Container(
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
                ),
              ),
              FlashSale(),
            ],
          )
        : Scaffold(
            appBar: AppBar(),
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
                Container(
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
                  ),
                ),
                FlashSale(),
              ],
            ),
          );
  }
}
