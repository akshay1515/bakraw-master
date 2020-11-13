import 'dart:convert';

import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/databasehelper.dart';
import 'package:bakraw/model/addtocartmodel.dart';
import 'package:bakraw/model/carttoproductmodel.dart';
import 'package:bakraw/model/internalcart.dart';
import 'package:bakraw/model/paymentGatewayModels.dart';
import 'package:bakraw/model/productmodel.dart' as Data;
import 'package:bakraw/model/taxmodel.dart';
import 'package:bakraw/model/useraddressmodel.dart';
import 'package:bakraw/provider/carttoserverprovider.dart';
import 'package:bakraw/provider/productdetailprovider.dart';
import 'package:bakraw/screen/dashboard.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/widget/success_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentsPage extends StatefulWidget {
  addressData model;
  String deliveryslot;
  double amount;
  String shippinglable;
  String Shippingcost;
  String Taxid;
  String taxamount;

  PaymentsPage(
    addressData model,
    String deliveryslot,
    double amount,
    String shippinglable,
    String Shippingcost,
    String Taxid,
    String taxamount,
  ) {
    this.model = model;
    this.deliveryslot = deliveryslot;
    this.amount = amount;
    this.Shippingcost = Shippingcost;
    this.shippinglable = shippinglable;
    this.Taxid = Taxid;
    this.taxamount = taxamount;
  }

  @override
  _PaymentsPageState createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  Razorpay _razorpay;
  String email = '';
  String apikey = '';
  String userid = '';
  String name = '';
  String mobile = '';
  String fname = '';
  String lname = '';
  TextEditingController coupon = TextEditingController();
  bool isLoading = true;
  List<CartsModel> rowlist;
  double subtotal = 00.00;
  num taxamount = 00;
  double total = 00.00;
  List<Data.Data> target = [];
  bool isinit = true;
  int count = 0;
  DbcarTmodel model;
  List<OrderProducts> list = [];
  List<ProductOptions> optionlist = [];
  List<Values> valuelist = [];
  TransactionDetails transactionDetails;
  TaxModel taxmodel;
  List<TaxDetails> taxdetails = [];
  List<CartProductModel> cartProducts = [];
  bool ispickup = false;
  bool isdelivery = true;
  String data = '';
  orderplacedmessage orderplaced;
  CircularProgressIndicator indicator = CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    if (isLoading) {
      getUserInfo();
      fetchcartItems();
      _razorpay = Razorpay();
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerpaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerpaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerpaymentwallet);
      Subtotal();
      setState(() {
        isdelivery = true;
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  Future<String> getUserInfo() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      setState(() {
        email = prefs.getString('email');
        apikey = prefs.getString('apikey');
        userid = prefs.getString('id');
        mobile = prefs.getString('mobile');
        fname = prefs.getString('fname');
        lname = prefs.getString('lname');
      });
    }
    return email;
  }

  double Subtotal() {
    for (int i = 0; i < rowlist.length; i++) {
      double total = double.parse(rowlist[i].price);
      int qty = int.parse(rowlist[i].quantity);
      setState(() {
        subtotal += total * qty;
      });
    }
    return subtotal;
  }

  void openCheckout() async {
    setState(() {
      ispickup = true;
    });
    var options = {
      "key": "rzp_test_uQ7Wk2tHdgWxS3",
      "amount": taxamount,
      "name": '${widget.model.userFirstname + ' '}${widget.model.userLastname}',
      "description": 'Purchased Meat',
      "prefill": {
        "contact": widget.model.userPhone,
        "email": widget.model.userEmail,
      },
      "external": {
        "wallets": ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void _showdialog({String message, String orderid}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogResponses(
            color: Colors.green[300],
            icon: Icons.check_circle,
            message: message,
            id: orderid,
          );
        });
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
      int index = 0;
      List<Values> vList = new List();

      for (CartsModel element in rowlist) {
        Data.ProductModel model =
            await Provider.of<ProductProvider>(context, listen: false)
                .getProductDetails(element.productid);
        target.add(Data.Data(
          name: model.data.name,
          productId: model.data.productId,
          isProductIsInSale: model.data.isProductIsInSale,
          productSaleDetails: model.data.productSaleDetails,
        ));

        List<Values> values = [];
        List<ProductOptions> optionsList = [];
        values.add(Values(
            optionValueId: int.parse(element.optionvalueId),
            increaseProductPriceBy: element.productpriceincreased));
        optionsList.add(ProductOptions(
            optionId: int.parse(element.optionid),
            optionName: element.optionname,
            optionLabel: element.optionlable,
            values: values));
        cartProducts
            .add(new CartProductModel(element, values, optionsList, target));
      }
      isinit = false;
    }

    setState(() {
      isLoading = false;
    });
  }

  void handlerpaymentSuccess(PaymentSuccessResponse response) {
    setState(() {
      indicator.visible(true);
    });
    transactionDetails = new TransactionDetails(
      transactionId: response.paymentId,
      paymentMethod: "razorpay",
      createdAt: DateTime.now().toString(),
      updatedAt: DateTime.now().toString(),
    );

    if (ispickup) {
      SendData();
    }
    /* _showdialog();*/
  }

  SendData() {
    PlaceOrder();
    Provider.of<CartToserverProvider>(context, listen: false)
        .PlaceOrderInCart(data, apikey)
        .then((value) {
      orderplaced = orderplacedmessage(
          message: value.message, status: value.status, data: value.data);
      var i = DatabaseHelper.instance.TrunccateTable();
      print('database deleted $i');
      setState(() {
        indicator.visible(false);
        ispickup = false;
        _showdialog(
            message: orderplaced.message,
            orderid: orderplaced.data.orderId.toString());
      });
    });
  }

  void handlerpaymentError(PaymentFailureResponse response) {
    _showdialog(message: response.message, orderid: response.code.toString());
  }

  void handlerpaymentwallet() {
    Fluttertoast.showToast(msg: 'error', toastLength: Toast.LENGTH_SHORT);
  }

  PlaceOrder() {
    taxdetails.add(TaxDetails(
        taxRateId: int.parse(widget.Taxid), amount: widget.taxamount));
    print('userid $userid');
    Map<String, dynamic> mapData = new Map();
    mapData["user_id"] = int.parse(userid);
    mapData["user_first_name"] = fname;
    mapData["user_last_name"] = lname;
    mapData["user_phone"] = mobile;
    mapData["user_email"] = email;
    mapData["billing_first_name"] = fname;
    mapData["billing_last_name"] = lname;
    mapData["billing_address_1"] = widget.model.shippingAddress1;
    mapData["billing_address_2"] = widget.model.shippingAddress2;
    mapData["billing_city"] = widget.model.billingCity;
    mapData["billing_state"] = widget.model.billingState;
    mapData["billing_zip"] = widget.model.billingZip;
    mapData["billing_country"] = widget.model.shippingCountry;
    mapData["shipping_first_name"] = fname;
    mapData["shipping_last_name"] = lname;
    mapData["shipping_address_1"] = widget.model.shippingAddress1;
    mapData["shipping_address_2"] = widget.model.shippingAddress2;
    mapData["shipping_city"] = widget.model.billingCity;
    mapData["shipping_state"] = widget.model.billingState;
    mapData["shipping_zip"] = widget.model.billingZip;
    mapData["shipping_country"] = widget.model.shippingCountry;
    mapData["sub_total"] = widget.amount.toString();
    mapData["shipping_method"] = widget.shippinglable;
    mapData["shipping_cost"] = widget.Shippingcost;
    mapData["coupon_id"] = "";
    mapData["discount"] = "0.0";
    mapData["total"] = widget.amount.toString();
    mapData["payment_method"] = "razorpay";
    mapData["currency"] = "INR";
    mapData["currency_rate"] = "1.000";
    mapData["locale"] = "en";
    mapData["status"] = "pending";
    mapData["delivery_slot"] = widget.deliveryslot.toString();
    mapData["note"] = "string";
    mapData["created_at"] = DateTime.now().toString();
    mapData["updated_at"] = DateTime.now().toString();

    for (int i = 0; i < cartProducts.length; i++) {
      if (target[i].isProductIsInSale == true) {
        print('target ${target[i].productSaleDetails.saleProductId}');
        list.add(OrderProducts(
            productSaleDetails: ProductSaleDetails(
                saleProductId: num.parse(cartProducts[i]
                    .target[i]
                    .productSaleDetails
                    .saleProductId)),
            productId: cartProducts[i].target[i].productId,
            productName: cartProducts[i].target[i].name,
            isProductIsInSale: cartProducts[i].target[i].isProductIsInSale,
            qty: cartProducts[i].cartModel.quantity,
            unitPrice: cartProducts[i].cartModel.price,
            lineTotal: (double.parse(cartProducts[i].cartModel.price) *
                    int.parse(cartProducts[i].cartModel.quantity))
                .toString(),
            productOptions: cartProducts[i].optionlist));
      } else {
        list.add(OrderProducts(
            productSaleDetails: ProductSaleDetails(),
            productId: cartProducts[i].target[i].productId,
            productName: cartProducts[i].target[i].name,
            isProductIsInSale: cartProducts[i].target[i].isProductIsInSale,
            qty: cartProducts[i].cartModel.quantity,
            unitPrice: cartProducts[i].cartModel.price,
            lineTotal: (double.parse(cartProducts[i].cartModel.price) *
                    int.parse(cartProducts[i].cartModel.quantity))
                .toString(),
            productOptions: cartProducts[i].optionlist));
      }
    }

    print('list ${list.length}');
    mapData["tax_details"] = taxdetails;
    mapData["order_products"] = list;

    mapData["transaction_details"] = transactionDetails.toJson();
    data = jsonEncode(mapData);

    /* Provider.of<CartToserverProvider>(context, listen: false)
        .PlaceOrderInCart(json, apikey)
        .then((value) {});*/
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(grocery_colorPrimary);
    print('amount ${widget.amount}');
    double amount = double.parse(widget.amount.toStringAsFixed(2));
    if (isdelivery) {
      taxamount = num.parse((amount * 100).toString());
      openCheckout();
      setState(() {
        isdelivery = false;
      });
    }

    return ispickup
        ? Container(
            color: grocery_color_white,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: grocery_colorPrimary,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(),
            body: WillPopScope(
              onWillPop: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(Dashboard.Tag, (route) => false);
              },
              child: Container(
                child: Center(
                  child: Column(),
                ),
              ),
            ),
          );
  }
}
