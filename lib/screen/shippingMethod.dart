import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/databasehelper.dart';
import 'package:bakraw/model/addtocartmodel.dart';
import 'package:bakraw/model/internalcart.dart';
import 'package:bakraw/model/productmodel.dart' as Data;
import 'package:bakraw/model/shipmethod.dart' as dw;
import 'package:bakraw/model/taxmodel.dart';
import 'package:bakraw/model/useraddressmodel.dart';
import 'package:bakraw/provider/productdetailprovider.dart';
import 'package:bakraw/provider/shipmethodprovider.dart';
import 'package:bakraw/provider/taxProvider.dart';
import 'package:bakraw/screen/paymentGateway.dart';
import 'package:bakraw/utils/GeoceryStrings.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:bakraw/utils/GroceryWidget.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShippingMethod extends StatefulWidget {
  addressData model;
  String deliveryslot;

  ShippingMethod(addressData model, String deliveryslot) {
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
  double subtotal = 00.00;
  double taxamount = 00.00;
  double total = 00.00;
  TaxModel taxmodel;
  List<CartsModel> rowlist;
  int count = 0;
  int defaultvalue = 0;
  bool loadsubtotal = true;
  TextEditingController coupon = TextEditingController();
  List<TaxDetail> taxdetails = [];
  var isLoading = true;
  List<dw.Data> Shippinglist;
  bool ispickup = true;
  bool isdelivery = false;
  bool isinit = true;
  List<Data.Data> target = [];
  String shippingcost;
  String Shippinglable;

  @override
  void initState() {
    super.initState();
    Shippinglist = [];
    getUserInfo();
    if (isinit == true) {
      fetchcartItems();
    }
  }

  Future fetchcartItems() async {
    print('set');
    subtotal = 0.0;
    if (rowlist == null) {
      rowlist = List<CartsModel>();
      count = 0;
    }
    count = await DatabaseHelper.instance.getCount();
    rowlist = await DatabaseHelper.instance.getcartItems();

    if (isinit == true) {
      rowlist.forEach((element) {
        //print('rowlist ${element.option}');
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
    setState(() {
      isLoading = false;
    });
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
    temp =
        ((Subtotal() / 100) * double.parse(taxmodel.data[0].taxRates[0].rate));

    return temp;
  }

  double finalTotal() {
    if (isdelivery) {
      total = (Subtotal() +
          Calculatetax() +
          double.parse(Shippinglist[0].freeShippingMinAmount));
      Shippinglable = Shippinglist[0].freeShippingLabel;
      shippingcost = Shippinglist[0].freeShippingMinAmount;
    } else {
      total = (Subtotal() + Calculatetax());
      Shippinglable = Shippinglist[0].localPickupLabel;
      shippingcost = Shippinglist[0].localPickupCost;
    }

    return total;
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
    return email;
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(grocery_colorPrimary);
    var width = MediaQuery.of(context).size.width;
    if (isLoading) {
      Provider.of<TaxProvider>(context)
          .getTaxlist(apikey, userid, email)
          .then((value) {
        taxmodel = TaxModel(
            status: value.status, message: value.message, data: value.data);
      }).then((value) {});

      Provider.of<ShipmethodProvider>(context)
          .getShippingmethod(userid, email, apikey)
          .then((value) {
        if (value.status == 200) {
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
        }
        print('Shippinglist ${Shippinglist[0].localPickupLabel}');
        setState(() {
          isLoading = false;
        });
      });
    }

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
            'Goatmeat',
            style: TextStyle(color: grocery_color_white),
          ),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            text(
                                '${grocery_lbl_subtotal}${' '}${'(${count} items)'}'),
                            text('₹ ${Subtotal().toString()}',
                                fontFamily: fontMedium),
                          ],
                        ),
                        SizedBox(height: spacing_control),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            text(
                                'Tax (${double.parse(taxmodel.data[defaultvalue].taxRates[defaultvalue].rate).toStringAsFixed(2)}%)',
                                textColor: grocery_textColorSecondary),
                            text("₹ ${Calculatetax()}",
                                textColor: grocery_textColorSecondary),
                          ],
                        ),
                        SizedBox(height: spacing_standard_new),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(color: grey)),
                                width: MediaQuery.of(context).size.width * 0.63,
                                child: TextFormField(
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  controller: coupon,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 7),
                                    hintText: 'Enter Coupon Code Here',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: groceryButton(
                                  onPressed: () {
                                    if (!coupon.text.isEmptyOrNull) {
                                      Fluttertoast.showToast(
                                          msg: 'Invalid Coupon Code',
                                          toastLength: Toast.LENGTH_SHORT);
                                    }
                                  },
                                  color: grocery_colorPrimary,
                                  textContent: 'Apply',
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: spacing_standard_new),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FittedBox(
                              child: groceryButton(
                                textContent: grocery_lbl_checkout,
                                onPressed: (() {
                                  !email.isEmptyOrNull
                                      ? subtotal <= 0
                                          ? Fluttertoast.showToast(
                                              msg: 'Your cart is Empty',
                                              toastLength: Toast.LENGTH_SHORT)
                                          : /*openCheckout()*/ PaymentsPage(
                                                  widget.model,
                                                  widget.deliveryslot,
                                                  finalTotal(),
                                                  Shippinglable,
                                                  shippingcost,
                                                  taxmodel.data[0].taxRates[0]
                                                      .taxRateId,
                                                  Calculatetax().toString())
                                              .launch(context)
                                      : Fluttertoast.showToast(
                                          msg: 'Please Login',
                                          toastLength: Toast.LENGTH_SHORT);
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
                        )
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 10),
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerLeft,
                      child: text('Select Delivery Method',
                          fontFamily: fontMedium)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          if (!isdelivery) {
                            setState(() {
                              isdelivery = !isdelivery;
                              ispickup = !ispickup;
                            });
                          }
                        },
                        child: Container(
                          height: 130,
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
                          if (!ispickup) {
                            setState(() {
                              isdelivery = !isdelivery;
                              ispickup = !ispickup;
                            });
                          }
                        },
                        child: Container(
                          height: 130,
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
                                  Text('₹ ${Shippinglist[1].localPickupCost}',
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
                ],
              ));

/*class RadioListBuilder extends StatefulWidget {
  List<String> optionlist;

  RadioListBuilder({Key key, this.optionlist}) : super(key: key);

  @override
  _RadioListBuilderState createState() => _RadioListBuilderState();
}*/

/*
class _RadioListBuilderState extends State<RadioListBuilder> {
  var samp;
  SelectedRadio(String val) {
    setState(() {
      selectedValue = val;
      Provider.of<DeliverySlotProvider>(context, listen: false)
          .UpdateOptionValue(val);
    });
  }

  var selectedValue;
  var sOptionPrice;
  var sOptionLable;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: widget.optionlist.length,
      itemBuilder: (context, index) {
        return SizedBox(
          width: MediaQuery.of(context).size.width / 2.3,
          child: RadioListTile(
              toggleable: false,
              controlAffinity: ListTileControlAffinity.platform,
              dense: true,
              title: Text(
                widget.optionlist[index],
                style: TextStyle(
                    fontFamily: fontMedium,
                    fontSize: MediaQuery.of(context).size.width / 23),
              ),
              value: widget.optionlist[index],
              groupValue: selectedValue,
              onChanged: (val) {
                SelectedRadio(selectedValue = val);
              }),
        );
      },
    );
  }*/
  }
}
