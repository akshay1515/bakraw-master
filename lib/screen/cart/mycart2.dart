import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/inherited/cart/cart_container.dart';
import 'package:bakraw/screen/cart/widgets/cart_products_list.dart';
import 'package:bakraw/screen/cart/widgets/fitted_box_widget.dart';
import 'package:bakraw/screen/cart/widgets/sub_total_widget.dart';
import 'package:bakraw/screen/newui/newhomepage.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:bakraw/widget/bakrawproperties.dart';
import 'package:bakraw/widget/bottomnavigationbar.dart';
import 'package:bakraw/widget/customappbar.dart';
import 'package:bakraw/widget/horizontallist.dart';
import 'package:bakraw/widget/searchbar.dart';
import 'package:flutter/material.dart';

class Mycart2 extends StatefulWidget {
  static const tag = '/mycart';

  @override
  _MycartState2 createState() => _MycartState2();
}

class _MycartState2 extends State<Mycart2> {
  @override
  Widget build(BuildContext context) {
    changeStatusColor(grocery_colorPrimary);
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
        child: Scaffold(
          appBar: CustomAppbar(),
          backgroundColor: Colors.green.shade50,
          body: CartContainer(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                    height: 210,
                                    width: double.infinity,
                                    color: Color.fromRGBO(51, 105, 30, 1)),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50)),
                                  margin: EdgeInsets.only(top: 40),
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
                            BakrawUniqueness(),
                            Searchbar(topmargin: 180)
                          ],
                        ),
                        SizedBox(height: spacing_standard_new),
                        CartProductsList(),
                        Container(
                          padding: EdgeInsets.all(spacing_standard_new),
                          margin: EdgeInsets.only(bottom: 80),
                          width: width,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: grocery_ShadowColor,
                                  blurRadius: 10,
                                  spreadRadius: 3)
                            ],
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(spacing_middle),
                                bottomLeft: Radius.circular(spacing_middle)),
                            color: grocery_color_white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: <Widget>[
                                  SubTotalWidget(),
                                  SizedBox(height: spacing_control),
                                  SizedBox(height: spacing_standard_new),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: FittedBoxWidget(),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  BottomNav(currentScreen: 1)
                ],
              ),
            ),
          ),
        ),
        onWillPop: () {
          Navigator.of(context)
              .pushReplacementNamed(NewHomepage.Tag, arguments: {'id': 0});
        });
  }
}
