import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/databasehelper.dart';
import 'package:bakraw/inherited/cart/cart_container.dart';
import 'package:bakraw/inherited/cart/cart_container_state.dart';
import 'package:bakraw/model/productmodel.dart' as Data;
import 'package:bakraw/utils/GeoceryStrings.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:bakraw/utils/GroceryWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nb_utils/nb_utils.dart';

class CartItem extends StatefulWidget {
  int id;
  String productid;
  String optionvalueid;
  String optionid;
  String optionname;
  String optionlable;
  String productpriceincreased;
  String price;
  String quantity;
  Data.Data mld;

  CartItem(
      this.id,
      this.productid,
      this.optionvalueid,
      this.optionid,
      this.optionname,
      this.optionlable,
      this.productpriceincreased,
      this.price,
      this.quantity,
      this.mld);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  CartContainerState state;
  void updateItemCount(BuildContext context) {
    CartContainer.of(context)
        .updateCartPricing(widget.optionvalueid, widget.quantity);
  }

  var width;

  Future<Widget> mRemoveItem() async {
    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: IntrinsicHeight(
              child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(spacing_large),
                    topRight: Radius.circular(spacing_large)),
                color: grocery_color_white),
            height: MediaQuery.of(context).size.height / 2.8,
            padding: EdgeInsets.all(spacing_standard_new),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          right: spacing_standard_new, top: spacing_middle),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: grocery_color_red),
                      padding: EdgeInsets.all(width * 0.02),
                      child: Icon(Icons.delete, color: grocery_color_white),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          text(grocery_lbl_remove_an_item,
                              fontFamily: fontMedium, fontSize: textSizeNormal),
                          text(grocery_lbl_remove_confirmation,
                              textColor: grocery_textColorSecondary,
                              isLongText: true),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: spacing_large),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: text("$grocery_lbl_no",
                            textColor: grocery_textColorSecondary,
                            textAllCaps: true,
                            fontFamily: fontMedium),
                      ),
                    ),
                    SizedBox(width: spacing_standard_new),
                    Container(
                      width: width * 0.35,
                      child: groceryButton(
                        textContent: grocery_lbl_remove,
                        onPressed: (() async {
                          int i = await DatabaseHelper.instance.deleteCartItem({
                            DatabaseHelper.productid: widget.productid,
                            DatabaseHelper.optionvalueid: widget.optionvalueid
                          });
                          i > 0
                              ? Fluttertoast.showToast(
                                  msg: 'Item Deleted Successfully',
                                  toastLength: Toast.LENGTH_SHORT)
                              : Fluttertoast.showToast(
                                  msg: 'Something Went Wrong',
                                  toastLength: Toast.LENGTH_SHORT);
                          Navigator.pop(context);
                        }),
                        bgColors: grocery_color_red,
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
        );
      },
    ).whenComplete(() {
      --CartContainer.of(context).count;
      CartContainer.of(context).updateCartPricing(widget.optionvalueid, "0");
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return Container(
      decoration: boxDecoration(
          showShadow: true, bgColor: grocery_color_white.withOpacity(0.9)),
      padding: EdgeInsets.fromLTRB(
          spacing_middle, 0, spacing_middle, spacing_middle),
      margin: EdgeInsets.only(
          left: spacing_standard_new,
          right: spacing_standard_new,
          bottom: spacing_standard_new),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: CachedNetworkImage(
                    placeholder: placeholderWidgetFn(),
                    imageUrl: widget.mld.images[0].path,
                    fit: BoxFit.fill,
                    height: width * 0.25,
                    width: width * 0.40,
                  ),
                ),
                SizedBox(height: spacing_control),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: spacing_standard, right: spacing_standard),
                      decoration: boxDecoration(
                          radius: spacing_control,
                          bgColor: grocery_light_gray_color),
                      margin: EdgeInsets.only(right: spacing_middle),
                      child: text(widget.optionlable,
                          fontSize: textSizeSmall, isCentered: true),
                    ),
                    text('₹ ${double.parse(widget.price).toStringAsFixed(2)}',
                        fontSize: textSizeLargeMedium),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    text(
                        '₹ ${(double.parse(widget.price) * int.parse(widget.quantity)).toStringAsFixed(2)}',
                        fontSize: textSizeLargeMedium,
                        fontFamily: fontMedium),
                    IconButton(
                      onPressed: () {
                        mRemoveItem();
                      },
                      icon:
                          Icon(Icons.delete_outline, color: grocery_icon_color),
                    )
                  ],
                ),
                Container(
                    transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                    child: text(widget.mld.name,
                        textColor: grocery_textColorSecondary)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.remove_circle_outline,
                            size: 28, color: grocery_icon_color),
                        onPressed: () async {
                          int temp = int.parse(widget.quantity);
                          int i;
                          if (temp > 1) {
                            temp--;
                            i = await DatabaseHelper.instance.updateCartitem({
                              DatabaseHelper.productid: widget.productid,
                              DatabaseHelper.optionvalueid:
                                  widget.optionvalueid,
                              DatabaseHelper.optionlable: widget.optionlable,
                              DatabaseHelper.price: widget.price,
                              DatabaseHelper.optionid: widget.optionid,
                              DatabaseHelper.optionname: widget.optionname,
                              DatabaseHelper.productpriceincreased:
                                  widget.productpriceincreased,
                              DatabaseHelper.quantity: temp.toString()
                            });
                            if (i > 0) {
                              setState(() {
                                widget.quantity = temp.toString();
                              });
                              updateItemCount(context);
                            }
                          } else {}
                        }),
                    text(widget.quantity,
                        fontFamily: fontMedium, fontSize: textSizeNormal),
                    IconButton(
                        icon: Icon(Icons.add_circle_outline,
                            size: 28, color: grocery_icon_color),
                        onPressed: () async {
                          int temp = int.parse(widget.quantity);
                          int i;
                          if (temp >= 1) {
                            temp++;
                            i = await DatabaseHelper.instance.updateCartitem({
                              DatabaseHelper.productid: widget.productid,
                              DatabaseHelper.optionvalueid:
                                  widget.optionvalueid,
                              DatabaseHelper.optionlable: widget.optionlable,
                              DatabaseHelper.optionid: widget.optionid,
                              DatabaseHelper.optionname: widget.optionname,
                              DatabaseHelper.productpriceincreased:
                                  widget.productpriceincreased,
                              DatabaseHelper.price: widget.price,
                              DatabaseHelper.quantity: temp.toString()
                            });
                            if (i > 0) {
                              setState(() {
                                widget.quantity = temp.toString();
                              });
                              updateItemCount(context);
                            }
                          } else {}
                        }),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
