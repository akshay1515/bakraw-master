import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/databasehelper.dart';
import 'package:bakraw/model/addtocartmodel.dart';
import 'package:bakraw/model/internalcart.dart';
import 'package:bakraw/model/productmodel.dart' as Data;
import 'package:bakraw/model/taxmodel.dart';
import 'package:bakraw/model/useraddressmodel.dart';
import 'package:bakraw/provider/carttoserverprovider.dart';
import 'package:bakraw/provider/productdetailprovider.dart';
import 'package:bakraw/utils/GroceryColors.dart';
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
  int taxamount = 00;
  double total = 00.00;
  List<Data.Data> target = [];
  bool isinit = true;
  int count = 0;
  DbcarTmodel model;
  List<OrderProduct> list = [];
  List<ProductOption> optionlist = [];
  List<Value> valuelist = [];
  TransactionDetails transactionDetails;
  TaxModel taxmodel;
  List<TaxDetail> taxdetails = [];
  bool ispickup = true;
  bool isdelivery = false;

  @override
  void initState() {
    super.initState();
    if (isLoading) getUserInfo();
    fetchcartItems();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerpaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerpaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerpaymentwallet);
    Subtotal();

    setState(() {
      isLoading = false;
    });
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
    var options = {
      "key": "rzp_test_uQ7Wk2tHdgWxS3",
      "amount": taxamount,
      "name": '${fname + ' '}${lname}',
      "description": 'Purchased Meat',
      "prefill": {
        "contact": mobile,
        "email": email,
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

    for (int j = 0; j < list.length; j++) {
      optionlist.add(ProductOption(
          optionId: int.parse(rowlist[j].optionid),
          optionName: rowlist[j].optionname,
          optionLabel: rowlist[j].optionlable,
          values: valuelist));
    }
    for (int k = 0; k < optionlist.length; k++) {
      valuelist.add(Value(
          optionValueId: int.parse(rowlist[k].optionvalueId),
          increaseProductPriceBy: rowlist[k].productpriceincreased));
    }

    for (int i = 0; i < rowlist.length; i++) {
      list.add(OrderProduct(
          productId: target[i].productId,
          productName: target[i].name,
          isProductIsInSale: target[i].isProductIsInSale,
          qty: rowlist[i].quantity,
          unitPrice: rowlist[i].price,
          lineTotal:
              (double.parse(rowlist[i].price) * int.parse(rowlist[i].quantity))
                  .toString(),
          productOptions: optionlist));
    }

    setState(() {
      isLoading = false;
    });
  }

  void handlerpaymentSuccess() {}

  void handlerpaymentError() {
    Fluttertoast.showToast(msg: 'failed', toastLength: Toast.LENGTH_SHORT);
  }

  void handlerpaymentwallet() {
    Fluttertoast.showToast(msg: 'error', toastLength: Toast.LENGTH_SHORT);
  }

  PlaceOrder() {
    if (ispickup)
      taxdetails.add(TaxDetail(
          taxRateId: int.parse(widget.Taxid), amount: widget.taxamount));

    model = DbcarTmodel(
        userId: 90,
        userFirstName: fname,
        userLastName: lname,
        userPhone: mobile,
        userEmail: email,
        shippingFirstName: widget.model.shippingFirstName,
        shippingLastName: widget.model.shippingLastName,
        shippingAddress1: widget.model.shippingAddress1,
        shippingAddress2: widget.model.shippingAddress2,
        shippingCity: widget.model.shippingCity,
        shippingState: widget.model.shippingState,
        shippingCountry: widget.model.shippingCountry,
        shippingZip: widget.model.shippingZip,
        billingFirstName: widget.model.billingFirstName,
        billingLastName: widget.model.billingLastName,
        billingAddress1: widget.model.billingAddress1,
        billingAddress2: widget.model.billingAddress2,
        billingCity: widget.model.billingCity,
        billingState: widget.model.billingState,
        billingZip: widget.model.billingZip,
        subTotal: widget.amount.toString(),
        shippingMethod: widget.shippinglable,
        billingCountry: 'IN',
        shippingCost: widget.Shippingcost,
        couponId: "",
        discount: "0.00",
        total: widget.amount.toString(),
        paymentMethod: 'razorpay',
        currency: 'INR',
        currencyRate: '1.00',
        locale: 'en',
        status: 'pending',
        deliverySlot: widget.deliveryslot,
        note: "",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        orderProducts: list,
        transactionDetails: transactionDetails,
        taxDetails: taxdetails);

    /*Map variable = model.toJson();*/
    String variable = model.userFirstName;

    print(variable);

    /* Provider.of<CartToserverProvider>(context, listen: false)
        .PlaceOrderInCart(model, apikey)
        .then((value) {});*/

    setState(() {
      ispickup = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(grocery_colorPrimary);
    var width = MediaQuery.of(context).size.width;
    print(widget.amount);
    taxamount = (widget.amount.toInt() * 100);
    PlaceOrder();
    /* openCheckout();*/
    Provider.of<CartToserverProvider>(context, listen: false)
        .PlaceOrderInCart(model, apikey)
        .then((value) {});

    return Scaffold(
      appBar: AppBar(),
      body: ispickup
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(),
    );
  }
}
