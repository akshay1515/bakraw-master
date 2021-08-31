import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/widget/bakrawproperties.dart';
import 'package:bakraw/widget/bannercarousel.dart';
import 'package:bakraw/widget/bestsellingproduct.dart';
import 'package:bakraw/widget/bottomnavigationbar.dart';
import 'package:bakraw/widget/couponslider.dart';
import 'package:bakraw/widget/customappbar.dart';
import 'package:bakraw/widget/horizontallist.dart';
import 'package:bakraw/widget/previousorderscreen.dart';
import 'package:bakraw/widget/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewHomepage extends StatelessWidget {
  static String Tag = '/newDashboard';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: CustomAppbar(),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 250,
                        child: BannerSlider(),
                      ),
                      Container(
                          height: 200,
                          width: double.infinity,
                          color: Color.fromRGBO(51, 105, 30, 1)),
                      Container(
                        height: 280,
                        width: double.infinity,
                        color: Colors.green.shade50.withOpacity(1.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                left: 10,
                              ),
                              margin: EdgeInsets.only(
                                  top: 10, left: 10, bottom: 10),
                              child: Text(
                                'Bestseller',
                                style: TextStyle(
                                    color: grocery_colorPrimary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(child: BestSelling()),
                          ],
                        ),
                      ),
                      Container(
                        height: 270,
                        width: double.infinity,
                        color: Colors.green.shade50.withOpacity(1.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                left: 10,
                              ),
                              margin: EdgeInsets.only(
                                top: 10,
                                left: 10,
                              ),
                              child: Text(
                                'All Meat',
                                style: TextStyle(
                                    color: grocery_colorPrimary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(child: PreviousOrder()),
                          ],
                        ),
                      ),
                      Container(
                        child: CouponSlider(),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Searchbar(
                        topmargin: 220,
                      ),
                      BakrawUniqueness(),
                      Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      style: BorderStyle.solid,
                                      color: grocery_colorPrimary_light,
                                      width: 3))),
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.only(top: 10),
                          child: HorizontalScrollview())
                    ],
                  ),
                ],
              ),
            ),
            BottomNav(currentScreen: 0)
          ],
        ),
      ),
      onWillPop: () {
        SystemNavigator.pop();

        return;
      },
    );
  }
}
