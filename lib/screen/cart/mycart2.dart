import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/inherited/cart/cart_container.dart';
import 'package:bakraw/screen/cart/widgets/cart_products_list.dart';
import 'package:bakraw/screen/cart/widgets/fitted_box_widget.dart';
import 'package:bakraw/screen/cart/widgets/sub_total_widget.dart';
import 'package:bakraw/screen/dashboard.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

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
    return Scaffold(
      body: CartContainer(
        child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(spacing_standard_new),
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
                      child: Column(
                        children: <Widget>[
                          SubTotalWidget(),
                          SizedBox(height: spacing_control),
                          SizedBox(height: spacing_standard_new),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              text("Continue",
                                      textColor: grocery_colorPrimary,
                                      textAllCaps: true,
                                      fontFamily: fontMedium)
                                  .onTap(
                                () {
                                  Navigator.of(context)
                                      .pushReplacementNamed(Dashboard.Tag);
                                },
                              ),
                              SizedBox(width: spacing_standard_new),
                              FittedBoxWidget(),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: spacing_standard_new),
                    CartProductsList(),
                  ],
                ),
              ),
      ),
    );


  }
}