import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/orderhistorymodel.dart';
import 'package:bakraw/provider/orderhistoryprovider.dart';
import 'package:bakraw/screen/newui/newhomepage.dart';
import 'package:bakraw/utils/GeoceryStrings.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:bakraw/widget/orderdetailscard.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/scheduler.dart';

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
    getUserInfo();
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
    setState(() {
      onLoad = true;
    });
    return userid;
  }

  @override
  Widget build(BuildContext context) {

    if (isLoading == true && isinit == true) {
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
         /* onLoad = false;*/
          isinit = false;
          isLoading = false;
        });
      });
    }

    final compleated = ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            decoration: boxDecoration(
                showShadow: true, radius: 10.0, bgColor: grocery_color_white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      color: grocery_colorPrimary,
                      child: Icon(
                        Icons.shopping_cart,
                        color: grocery_color_white,
                      ),
                    ).cornerRadiusWithClipRRect(25),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          text(
                            list[index].createdAt,
                            fontSize: textSizeNormal,
                            fontFamily: fontMedium,
                          ).paddingOnly(bottom: 16),
                          text(
                            list[index].status,
                            fontSize: textSizeMedium,
                            fontFamily: fontMedium,
                          ),
                          text(grocery_subtotal + ': ₹' + list[index].total,
                              fontSize: textSizeMedium,
                              fontFamily: fontMedium,
                              textColor: textSecondaryColor)
                        ],
                      ).paddingOnly(left: 16, right: 16),
                    ),
                  ],
                ),
                Divider().paddingOnly(top: 8),
                Row(
                  children: <Widget>[
                    Expanded(child: SizedBox()),
                    MaterialButton(
                        height: 40,
                        minWidth: 150,
                        padding: const EdgeInsets.all(0.0),
                        child: Text('Order Details',
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.center)
                            .cornerRadiusWithClipRRect(25),
                        textColor: grocery_color_white,
                        color: grocery_colorPrimary,
                        onPressed: () {
                          OrderDetailsCard(
                            orderid: list[index].orderId,
                            apikey: apikey,
                            email: email,
                            userid: userid,
                          ).launch(context);
                        })
                  ],
                ).paddingOnly(top: 16)
              ],
            ).paddingOnly(left: 16, right: 16, top: 16, bottom: 16),
          ).paddingOnly(left: 16, right: 16, top: 16).onTap(() {});
        });


    if(onLoad){

      if(userid.isEmptyOrNull && count<1){
        count++;
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushNamed(
              NewHomepage.Tag, arguments: {'id': 4});
        });
        return Container(
          color: Colors.white,
        );
      }else{
        return  Scaffold(
          backgroundColor: grocery_app_background,
          body: SafeArea(
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(AppBar(
                  title: Text(
                    'Order History',
                    style: TextStyle(color: grocery_color_white),
                  ),
                  leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: grocery_color_white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ).preferredSize.height),
                child: Container(
                    color: grocery_colorPrimary,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.clear,
                              size: 30,
                              color: grocery_color_white,
                            ).paddingOnly(right: 24).onTap(() {
                              finish(context);
                            }),
                            Expanded(
                                child: text(grocery_orderHistory,
                                    fontSize: textSizeNormal,
                                    textColor: grocery_color_white,
                                    fontFamily: fontBold)),
                          ],
                        ).paddingOnly(left: 12, right: 16),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    )),
              ),
              body: isLoading
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : Container(
                width: MediaQuery.of(context).size.width,
                child: list.length > 0
                    ? Container(child: compleated)
                    : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.inbox,
                            color: grocery_colorPrimary,
                            size: MediaQuery.of(context)
                                .size
                                .height /
                                5,
                          ),
                        ),
                        Text(
                            '${'You Haven\'t Placed Any Order Yet '} '),
                      ],
                    )),
              ),
            ),
          ),
        );
      }
    }else{
      return Container(
        color: Colors.white,
      );
    }
  }
}
