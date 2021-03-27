import 'dart:convert';

import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/databasehelper.dart';
import 'package:bakraw/model/couponcodemoel.dart';
import 'package:bakraw/model/internalcart.dart';
import 'package:bakraw/model/productmodel.dart' as Data;
import 'package:bakraw/model/shipmethod.dart' as dw;
import 'package:bakraw/model/taxmodel.dart';
import 'package:bakraw/model/useraddressmodel.dart' as net;
import 'package:bakraw/provider/couponprovider.dart';
import 'package:bakraw/provider/productdetailprovider.dart';
import 'package:bakraw/provider/shipmethodprovider.dart';
import 'package:bakraw/provider/taxProvider.dart';
import 'package:bakraw/screen/paymentGateway.dart';
import 'package:bakraw/utils/GeoceryStrings.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:bakraw/utils/GroceryWidget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShippingMethod extends StatefulWidget {
  net.Data model;
  String deliveryslot;

  ShippingMethod(net.Data model, String deliveryslot) {
    this.model = model;
    this.deliveryslot = deliveryslot;
  }

  @override
  _ShippingMethodState createState() => _ShippingMethodState();
}

class _ShippingMethodState extends State<ShippingMethod> {
  String email = '';
  String apikey = '';
  String userid = '';
  String shippingcost = '0.0';
  String Shippinglable = 'local_pickup';
  String coupondata = '';

  double tempTax = 00;
  double subtotal = 00.00;
  double taxamount = 00.00;
  double total = 00.00;
  int count = 0;
  int defaultvalue = 0;

  bool loadsubtotal = true;
  bool ispickup = false;
  bool isdelivery = false;
  bool ispaynow = true;
  bool isCOD = false;
  bool paymentMode = true;
  bool isinit = true;
  bool isLoading = true;

  bool visiblity = false;
  Color textcolor = grocery_color_white;
  String coupontext = '';
  IconData icons;

  TaxModel taxmodel = TaxModel();
  CouponModel couponclass = CouponModel();

  List<taxData> taxdetails = [];
  List<Data.Data> target = [];
  List<CartsModel> rowlist = [];
  List<dw.Data> Shippinglist = [];
  List<int> couponProductId = [];
  List<int> couponCatid = [];

  TextEditingController coupon = TextEditingController();
  TextEditingController deliveryinstruction = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserInfo();
    if (isLoading) {
      if (isinit == true) {
        fetchcartItems();
      }
    }
  }

  Future fetchcartItems() async {
    subtotal = 0.0;
    if (rowlist == null) {
      rowlist = List<CartsModel>();
      count = 0;
    }
    count = await DatabaseHelper.instance.getCount();
    rowlist = await DatabaseHelper.instance.getcartItems();

    if (isinit == true) {
      rowlist.forEach((element) {
        Provider.of<ProductProvider>(context, listen: false)
            .getProductDetails(element.productid)
            .then((value) {
          target.add(Data.Data(
            name: value.data.name,
            productId: value.data.productId,
            isProductIsInSale: value.data.isProductIsInSale,
            productSaleDetails: value.data.productSaleDetails,
          ));
        }).then((value) {});
      });
      isinit = false;
    }
  }

  double Subtotal() {
    double temp = 0.0;
    for (int i = 0; i < rowlist.length; i++) {
      double total = double.parse(rowlist[i].price);
      int qty = int.parse(rowlist[i].quantity);
      temp += total * qty;
    }
    subtotal = temp;
    return subtotal;
  }

  double Calculatetax() {
    double temp = 0.0;
    temp = (taxmodel.data[defaultvalue].taxRates.length > 0
        ? (Subtotal() / 100) *
            double.parse(
                taxmodel.data[defaultvalue].taxRates[defaultvalue].rate)
        : (Subtotal() / 100) * 0);
    return double.parse(temp.toStringAsFixed(2));
  }

  double finalTotal() {
    double discount = 0;
    if (couponclass != null) {
      if (couponclass.status == 200) {
        if (couponclass.hasError == false) {
          discount = double.parse(couponclass.data.discountAmount);
        }
      }
    }
    total = (Subtotal() + Calculatetax() - discount);
    if (isdelivery) {
      total = (Subtotal() +
          Calculatetax() +
          double.parse(Shippinglist[defaultvalue].freeShippingMinAmount));
      Shippinglable = Shippinglist[defaultvalue].freeShippingLabel;
      shippingcost =
          double.parse(Shippinglist[defaultvalue].freeShippingMinAmount)
              .toStringAsFixed(2);
    } else if (ispickup) {
      total = (Subtotal() + Calculatetax());
      Shippinglable = Shippinglist[1].localPickupLabel;
      shippingcost =
          double.parse(Shippinglist[1].localPickupCost).toStringAsFixed(2);
    }
    return double.parse(total.toStringAsFixed(2));
  }

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
    return userid;
  }

  Widget couponstatus() {
    return Visibility(
      child: Container(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Icon(
              icons,
              color: textcolor,
            ),
            Text(
              coupontext,
              style: TextStyle(
                  color: textcolor,
                  fontFamily: fontBold,
                  fontSize: textSizeMedium),
            ),
          ],
        ),
      ),
      visible: visiblity,
    );
  }

  CouponData() {
    Map<String, dynamic> mapData = new Map();
    mapData['user_id'] = int.parse(userid);
    mapData['user_email'] = email;
    mapData['order_total'] = total.toStringAsFixed(2);
    mapData['current_date'] = DateFormate();
    mapData['coupon_code'] = coupon.text.toString();
    for (int i = 0; i < rowlist.length; i++) {
      couponProductId.add(num.parse(rowlist[i].productid));
    }
    mapData['product_ids'] = couponProductId;

    coupondata = jsonEncode(mapData);
  }

  String DateFormate() {
    final df = new DateFormat('yyyy-MM-dd');
    final fdate = df.format(DateTime.now());

    return fdate.toString();
  }

  void applyCoupon() {
    CouponData();
    Provider.of<CouponProvider>(context, listen: false)
        .verifyCuopon(userid, email, apikey, coupondata)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          visiblity = true;
          textcolor = grocery_colorPrimary;
          coupontext =
              "You have saved ₹ ${double.parse(value.data.discountAmount).toStringAsFixed(2)}";
          icons = Icons.check_circle;
        });
      } else {
        setState(() {
          visiblity = true;
          textcolor = grocery_color_red;
          coupontext = value.message;
          icons = Icons.error_rounded;
        });
      }
      couponclass = CouponModel(
          status: value.status,
          hasError: value.hasError,
          data: value.data,
          message: value.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(grocery_colorPrimary);
    var width = MediaQuery.of(context).size.width;

    Future<List<dw.Data>> getDeliveryMethod() async {
      Provider.of<ShipmethodProvider>(context)
          .getShippingmethod(userid, email, apikey)
          .then((value) {
        value.data.forEach((element) {
          Shippinglist.add(dw.Data(
              freeShippingName: element.freeShippingName,
              freeShippingLabel: element.freeShippingLabel,
              freeShippingEnabled: element.freeShippingEnabled,
              freeShippingMinAmount: element.freeShippingMinAmount,
              localPickupCost: element.localPickupCost,
              localPickupEnabled: element.localPickupEnabled,
              localPickupLabel: element.localPickupLabel,
              localPickupName: element.localPickupName));
        });
        return Shippinglist;
      });
    }

    Future<TaxModel> getTaxdetails() async {
      Provider.of<TaxProvider>(context)
          .getTaxlist(apikey, userid, email)
          .then((value) {
        taxmodel = TaxModel(
            status: value.status, message: value.message, data: value.data);

        value.data[0].taxRates.isNotEmpty
            ? tempTax = double.parse(value.data[0].taxRates[0].rate)
            : '0.0';

        return taxmodel;
      });
    }

    return FutureBuilder(
        future: Future.wait([
          getTaxdetails(),
          getDeliveryMethod(),
        ]),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: grocery_app_background,
              appBar: AppBar(
                leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: grocery_color_white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                title: Text(
                  'Overview',
                  style: TextStyle(color: grocery_color_white),
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  text(
                                      '${grocery_lbl_subtotal}${' '}${'(${count} items)'}'),
                                  text('₹ ${Subtotal().toString()}',
                                      fontFamily: fontMedium),
                                ],
                              ),
                              SizedBox(height: spacing_control),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  text('Tax (${tempTax.toStringAsFixed(2)}%)',
                                      textColor: grocery_textColorSecondary),
                                  text("₹ ${Calculatetax()}",
                                      textColor: grocery_textColorSecondary),
                                ],
                              ),
                              Visibility(
                                child: Column(
                                  children: [
                                    SizedBox(height: spacing_control),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        text('Discount ',
                                            textColor: grocery_color_red),
                                        text(
                                            couponclass != null
                                                ? couponclass.status == 200
                                                    ? "- ₹ ${double.parse(couponclass.data.discountAmount).toStringAsFixed(2)}"
                                                    : ""
                                                : "",
                                            textColor: grocery_color_red),
                                      ],
                                    ),
                                  ],
                                ),
                                visible: couponclass != null
                                    ? couponclass.status == 200
                                        ? true
                                        : false
                                    : false,
                              ),
                              SizedBox(height: spacing_standard_new),
                              Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                            vertical: 3,
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.63,
                                          child: TextFormField(
                                            textCapitalization:
                                                TextCapitalization.characters,
                                            controller: coupon,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.only(left: 7),
                                              hintText:
                                                  'Enter Coupon Code Here',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: groceryButton(
                                            bgColors: grocery_colorPrimary,
                                            onPressed: () {
                                              applyCoupon();
                                            },
                                            color: grocery_colorPrimary,
                                            textContent: 'Apply',
                                          ),
                                        ),
                                      ],
                                    ),
                                    couponstatus()
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          padding: EdgeInsets.symmetric(vertical: 2),
                          width: width,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            boxShadow: [
                              BoxShadow(
                                  color: grocery_ShadowColor,
                                  blurRadius: 10,
                                  spreadRadius: 3)
                            ],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(spacing_middle),
                                topRight: Radius.circular(spacing_middle),
                                bottomRight: Radius.circular(spacing_middle),
                                bottomLeft: Radius.circular(spacing_middle)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: spacing_standard),
                              color: grocery_color_white,
                              child: TextFormField(
                                controller: deliveryinstruction,
                                minLines: 3,
                                maxLines: 5,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(left: 3, right: 7),
                                  hintText: 'Delivery Instructions',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.centerLeft,
                            child: text('Select Delivery Method',
                                fontFamily: fontMedium)),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  if (!isdelivery && !ispickup) {
                                    setState(() {
                                      isdelivery = !isdelivery;
                                      ispickup = ispickup;
                                    });
                                  } else {
                                    setState(() {
                                      isdelivery = !isdelivery;
                                      ispickup = !ispickup;
                                    });
                                  }
                                },
                                child: Container(
                                  height: 150,
                                  child: Card(
                                    color: isdelivery
                                        ? grocery_colorPrimary
                                        : grocery_color_white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: <Widget>[
                                          Icon(
                                            Icons.delivery_dining,
                                            size: 50,
                                            color: isdelivery
                                                ? grocery_color_white
                                                : grocery_colorPrimary,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            Shippinglist[0].freeShippingName,
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: !isdelivery
                                                  ? grocery_Color_black
                                                  : grocery_color_white,
                                            ),
                                          ),
                                          Text(
                                            '₹ ${Shippinglist[0].freeShippingMinAmount}',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: !isdelivery
                                                  ? grocery_Color_black
                                                  : grocery_color_white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (!isdelivery && !ispickup) {
                                    setState(() {
                                      isdelivery = isdelivery;
                                      ispickup = !ispickup;
                                    });
                                  } else {
                                    setState(() {
                                      isdelivery = !isdelivery;
                                      ispickup = !ispickup;
                                    });
                                  }
                                },
                                child: Container(
                                  height: 150,
                                  child: Card(
                                    color: ispickup
                                        ? grocery_colorPrimary
                                        : grocery_color_white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: <Widget>[
                                          Icon(
                                            Icons.storefront,
                                            color: ispickup
                                                ? grocery_color_white
                                                : grocery_colorPrimary,
                                            size: 50,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            Shippinglist[1].localPickupName,
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: !ispickup
                                                  ? grocery_Color_black
                                                  : grocery_color_white,
                                            ),
                                          ),
                                          Text(
                                              '₹ ${Shippinglist[1].localPickupCost}',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: !ispickup
                                                    ? grocery_Color_black
                                                    : grocery_color_white,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: spacing_standard_new),
                            padding: EdgeInsets.only(left: 10),
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.centerLeft,
                            child: text('Select Payment Method',
                                fontFamily: fontMedium)),
                        Container(
                          margin: EdgeInsets.only(
                              left: 10, right: 10, top: spacing_standard),
                          color: grocery_color_white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (!ispaynow) {
                                    setState(() {
                                      ispaynow = true;
                                      isCOD = false;
                                      paymentMode = ispaynow;
                                    });
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: grocery_color_white,
                                      border: Border(
                                          bottom: BorderSide(
                                              color: grocery_lightGrey))),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  width: MediaQuery.of(context).size.width,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Pay Now',
                                          style: TextStyle(
                                              color: grocery_Color_black,
                                              fontSize: textSizeLargeMedium),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Visibility(
                                          child: Icon(
                                            Icons.check,
                                            color: grocery_colorPrimary,
                                          ),
                                          visible: ispaynow,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (!isCOD) {
                                    setState(() {
                                      ispaynow = false;
                                      isCOD = true;
                                      paymentMode = ispaynow;
                                    });
                                  }
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: grocery_color_white,
                                        border: Border(
                                            bottom: BorderSide(
                                                color: grocery_color_white))),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                    width: MediaQuery.of(context).size.width,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Cash On Delivery',
                                            style: TextStyle(
                                                color: grocery_Color_black,
                                                fontSize: textSizeLargeMedium),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Visibility(
                                            child: Icon(
                                              Icons.check,
                                              color: grocery_colorPrimary,
                                            ),
                                            visible: !ispaynow,
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: Container(
                color: grocery_color_white,
                height: AppBar().preferredSize.height * 1.2,
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.only(bottom: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FittedBox(
                      child: groceryButton(
                        bgColors: grocery_colorPrimary,
                        textContent: grocery_lbl_checkout,
                        onPressed: (() {
                          String deliveryinstructions = "";
                          if (deliveryinstruction.text != null ||
                              deliveryinstruction.text.isNotEmpty) {
                            deliveryinstructions =
                                deliveryinstruction.text.toString();
                          }
                          if (shippingcost == null ||
                              shippingcost.isEmpty && Shippinglable == null ||
                              Shippinglable.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Please Select Shipping Method',
                                toastLength: Toast.LENGTH_SHORT);
                          } else {
                            /* Fluttertoast.showToast(
                                msg: paymentMode.toString(),
                                toastLength: Toast.LENGTH_SHORT);*/
                            userid != null || !userid.isEmpty
                                ? subtotal <= 0
                                    ? Fluttertoast.showToast(
                                        msg: 'Your cart is Empty',
                                        toastLength: Toast.LENGTH_SHORT)
                                    : Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => PaymentsPage(
                                                widget.model,
                                                widget.deliveryslot,
                                                finalTotal(),
                                                deliveryinstructions,
                                                Shippinglable,
                                                shippingcost,
                                                taxmodel.data[0].taxRates[0]
                                                    .taxRateId,
                                                Calculatetax()
                                                    .toStringAsFixed(2),
                                                paymentMode,
                                                couponclass)))
                                : Fluttertoast.showToast(
                                    msg: 'Please Login',
                                    toastLength: Toast.LENGTH_SHORT);
                          }
                        }),
                      ),
                    ),
                    Text(
                      'Total ₹ ${finalTotal()}',
                      style: TextStyle(
                          fontFamily: fontMedium,
                          fontSize: textSizeLargeMedium),
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
}
