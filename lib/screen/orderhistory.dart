import 'dart:ui';

import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/orderhistorymodel.dart';
import 'package:bakraw/provider/orderhistoryprovider.dart';
import 'package:bakraw/screen/newui/newsignup.dart';
import 'package:bakraw/utils/GeoceryStrings.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:bakraw/widget/customappbar.dart';
import 'package:bakraw/widget/orderdetailscard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroceryOrderHistoryScreen extends StatefulWidget {
  static String tag = '/GroceryOrderHistoryScreen';

  @override
  _GroceryOrderHistoryScreenState createState() =>
      _GroceryOrderHistoryScreenState();
}

class _GroceryOrderHistoryScreenState extends State<GroceryOrderHistoryScreen> {
  List<Data> listCompleated = [];
  String userid = '', email = '', apikey = '';
  bool isinit = true;
  List<Data> list = [];
  List<Data> sortedlist = [];
  bool isLoading = true;
  bool onLoad = false;
  int count = 0;

  @override
  void initState() {
    getUserInfo().then((value) {
      setState(() {
        onLoad = true;
      });
    });
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    if (onLoad && userid != null) {
      Provider.of<OrderHistoryProvider>(context, listen: false)
          .getPastOrder(email: email, apikey: apikey, userid: userid)
          .then((value) {
        value.data.forEach((element) {
          list.add(Data(
              total: element.total,
              subTotal: element.subTotal,
              orderId: element.orderId,
              createdAt: element.createdAt,
              status: element.status));
        });
        setState(() {
          onLoad = false;
          isinit = false;
          isLoading = false;
        });
      });
    }

    final compleated = ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(1, 1))
                    ],
                    color: grocery_color_white,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: grocery_colorPrimary,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(25),
                                    topRight: Radius.circular(25))),
                            child: Icon(
                              Icons.shopping_cart,
                              color: grocery_color_white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 08),
                                  child: text(
                                    list[index].createdAt,
                                    fontSize: textSizeNormal,
                                    fontFamily: fontMedium,
                                  ),
                                ),
                                text(
                                  list[index].status,
                                  fontSize: textSizeMedium,
                                  fontFamily: fontMedium,
                                ),
                                text(
                                    grocery_subtotal +
                                        ': ₹' +
                                        '${double.tryParse(
                                          list[index].total,
                                        ).toStringAsFixed(2)}',
                                    fontSize: textSizeMedium,
                                    fontFamily: fontMedium,
                                    textColor: grocery_textColorSecondary)
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Divider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            MaterialButton(
                                height: 40,
                                minWidth: 150,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                padding: const EdgeInsets.all(0.0),
                                child: Text('Order Details',
                                    style: TextStyle(fontSize: 18),
                                    textAlign: TextAlign.center),
                                textColor: grocery_color_white,
                                color: grocery_colorPrimary,
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => OrderDetailsCard(
                                            orderid: list[index].orderId,
                                            apikey: apikey,
                                            email: email,
                                            userid: userid,
                                          )));
                                })
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          );
        });

    if (onLoad) {
      if (userid == null || userid.isEmpty && count < 1) {
        count++;
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).popAndPushNamed(NewLogin.Tag);
        });
        return Container(
          color: Colors.white,
        );
      } else {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.grey.shade50,
            appBar: AppBar(
              title: Text('Order History'),
            ),
            body: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    child: list.length > 0
                        ? SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 8.0),
                                  child: Text(
                                    'My Past Orders',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 20,
                                        decoration: TextDecoration.underline,
                                        decorationStyle:
                                            TextDecorationStyle.dotted,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: fontMedium,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                compleated
                              ],
                            ),
                          )
                        : Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.inbox,
                                  color: grocery_colorPrimary,
                                  size: MediaQuery.of(context).size.height / 5,
                                ),
                              ),
                              Text('${'You Haven\'t Placed Any Order Yet '} '),
                            ],
                          )),
                  ),
          ),
        );
      }
    } else {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade50,
          appBar: AppBar(
            title: Text('Order History'),
          ),
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  child: list.length > 0
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 8.0),
                                child: Text(
                                  'My Past Orders',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 20,
                                      decoration: TextDecoration.underline,
                                      decorationStyle:
                                          TextDecorationStyle.dotted,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: fontMedium,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              compleated
                            ],
                          ),
                        )
                      : Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.inbox,
                                color: grocery_colorPrimary,
                                size: MediaQuery.of(context).size.height / 5,
                              ),
                            ),
                            Text('${'You Haven\'t Placed Any Order Yet '} '),
                          ],
                        )),
                ),
        ),
      );
    }
  }
}
