import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/databasehelper.dart';
import 'package:bakraw/inherited/cart/cart_container.dart';
import 'package:bakraw/inherited/cart/cart_container_state.dart';
import 'package:bakraw/model/productmodel.dart' as Data;
import 'package:bakraw/screen/newui/newproductdetail.dart';
import 'package:bakraw/utils/GeoceryStrings.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:bakraw/utils/GroceryWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

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
  var price;

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

  getPrice() {
    price = widget.mld.productOptions[0].options.where((element) {
      return element.optionValueId.contains(widget.optionvalueid);
    }).toList();
    return price;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(NewProductDetails.tag,
            arguments: {'prodid': widget.productid, 'names': widget.mld.name});
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Container(
          padding: EdgeInsets.zero,
          height: 152,
          decoration: boxDecoration(
              showShadow: true, bgColor: grocery_color_white.withOpacity(0.9)),
          /* padding: EdgeInsets.fromLTRB(
              spacing_middle, 0, spacing_middle, spacing_middle),*/
          margin: EdgeInsets.only(
              left: spacing_standard_new,
              right: spacing_standard_new,
              bottom: spacing_standard_new),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: CachedNetworkImage(
                      placeholder: placeholderWidgetFn(),
                      imageUrl: widget.mld.images[0].path,
                      fit: BoxFit.cover,
                      width: 175,
                      height: 150,
                    ),
                  ),
                  /* text(
                      '₹ ${(widget.mld.isProductIsInSale? double.parse(widget.mld.productSaleDetails.price) * int.parse(widget.quantity):double.parse(widget.mld.price) * int.parse(widget.quantity)).toStringAsFixed(2)}',
                      textColor: grocery_colorPrimary,
                      fontSize: textSizeMedium,
                      fontFamily: fontMedium),*/
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Container(
                  transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(left: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.33,
                            child: Text(
                              widget.mld.name,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              softWrap: true,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            child: IconButton(
                              onPressed: () {
                                mRemoveItem();
                              },
                              icon: Icon(Icons.delete_outline,
                                  color: grocery_colorPrimary_light),
                            ),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                      ),
                      Container(
                        transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SmoothStarRating(
                              color: Colors.amber.shade500,
                              allowHalfRating: true,
                              isReadOnly: true,
                              starCount: 5,
                              rating: double.parse(
                                  widget.mld.productRating.avgRating),
                              size: 17,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1),
                              child: Text(
                                '(${widget.mld.productRating.totalReviewsCount})',
                                style: TextStyle(fontSize: 10),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(0.0, 0.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 10,
                              width: 7,
                              padding: EdgeInsets.only(
                                  left: spacing_standard,
                                  right: spacing_standard),
                              decoration: BoxDecoration(
                                  color: Colors.green.shade700,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50),
                                      bottomRight: Radius.circular(50))),
                              margin: EdgeInsets.only(right: spacing_middle),
                            ),
                            Text(
                              '₹ ${(widget.mld.isProductIsInSale ? double.parse(widget.mld.productSaleDetails.price + double.parse(getPrice()[0].price)) : (double.parse(getPrice()[0].price) + double.parse(widget.mld.price)))}',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green.shade700),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(15.0, 7.0, 0.0),
                        child: SizedBox(
                          width: 75,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () async {
                                  int temp = int.parse(widget.quantity);
                                  int i;
                                  if (temp > 1) {
                                    temp--;
                                    i = await DatabaseHelper.instance
                                        .updateCartitem({
                                      DatabaseHelper.productid:
                                          widget.productid,
                                      DatabaseHelper.optionvalueid:
                                          widget.optionvalueid,
                                      DatabaseHelper.optionlable:
                                          widget.optionlable,
                                      DatabaseHelper.price: widget.price,
                                      DatabaseHelper.optionid: widget.optionid,
                                      DatabaseHelper.optionname:
                                          widget.optionname,
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
                                },
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: grocery_colorPrimary_light,
                                      borderRadius: BorderRadius.circular(17)),
                                  child: Center(
                                    child: Icon(Icons.remove,
                                        size: 20, color: grocery_color_white),
                                  ),
                                ),
                              ),
                              text(widget.quantity,
                                  fontFamily: fontMedium,
                                  fontSize: textSizeNormal),
                              GestureDetector(
                                onTap: () async {
                                  int temp = int.parse(widget.quantity);
                                  int i;
                                  if (temp >= 1) {
                                    temp++;
                                    i = await DatabaseHelper.instance
                                        .updateCartitem({
                                      DatabaseHelper.productid:
                                          widget.productid,
                                      DatabaseHelper.optionvalueid:
                                          widget.optionvalueid,
                                      DatabaseHelper.optionlable:
                                          widget.optionlable,
                                      DatabaseHelper.optionid: widget.optionid,
                                      DatabaseHelper.optionname:
                                          widget.optionname,
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
                                },
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: grocery_colorPrimary_light,
                                      borderRadius: BorderRadius.circular(17)),
                                  child: Center(
                                    child: Icon(Icons.add,
                                        size: 20, color: grocery_color_white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
