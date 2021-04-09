import 'package:bakraw/model/useraddressmodel.dart' as da;
import 'package:bakraw/provider/useraddressprovider.dart';
import 'package:bakraw/screen/editadduseraddress.dart';
import 'package:bakraw/screen/newui/newgooglemap.dart';
import 'package:bakraw/screen/newui/newhomepage.dart';
import 'package:bakraw/screen/newui/newsignup.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:bakraw/widget/addresswidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAddressManager extends StatefulWidget {
  static String tag = '/AddressManagerScreen';

  @override
  _UserAddressManagerState createState() => _UserAddressManagerState();
}

class _UserAddressManagerState extends State<UserAddressManager> {
  String email = '';
  String apikey = '';
  String userid = '';
  String fname = '';
  String lname = '';
  String mobile = '';
  List<da.Data> list = [];
  bool isloading = true;
  bool isinit = false;
  bool isfav = false;
  bool markFav = false;
  int count = 0;

  var selectedValue;
  var sOptionPrice;

  @override
  void initState() {
    getUserInfo().then((value) {
      setState(() {
        isinit = true;
      });
    });
  }

  Future<String> getUserInfo() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      setState(() {
        email = prefs.getString('email');
        apikey = prefs.getString('apikey');
        userid = prefs.getString('id');
        fname = prefs.getString('fname');
        lname = prefs.getString('lname');
        mobile = prefs.getString('mobile');
      });
    }

    return userid;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var argument = ModalRoute.of(context).settings.arguments as Map;

    if (isloading && isinit && userid != null) {
      Provider.of<UserAddressProvider>(context, listen: false)
          .getuserAddressList(userid, apikey)
          .then((value) {
        value.data.forEach((element) {
          list.add(da.Data(
              id: element.id,
              firstName: element.firstName,
              lastName: element.lastName,
              address1: element.address1,
              address2: element.address2,
              city: element.city,
              state: element.state,
              zip: element.zip,
              country: element.country,
              customerId: element.customerId,
              createdAt: element.createdAt,
              updatedAt: element.updatedAt));
        });
        setState(() {
          isloading = false;
        });
      });
    }
    if (isinit) {
      if (userid == null || userid.isEmpty) {
        if (count < 1) {
          count++;
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).popAndPushNamed(NewLogin.Tag);
          });
          return Container(
            color: Colors.white,
          );
        }
      } else {
        return WillPopScope(
          child: Scaffold(
            backgroundColor: grocery_app_background,
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: grocery_color_white,
                  ),
                  onPressed: () {
                    if (argument != null) {
                      Navigator.of(context).pop();
                    } else {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          NewHomepage.Tag, (route) => false,
                          arguments: {'id': 0});
                    }
                  }),
              title: Text(
                'My Addresses',
                style: TextStyle(color: grocery_color_white),
              ),
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.add,
                      color: grocery_color_white,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  EditUserAddress(
                                    isnav: argument['isnav'],
                                  )));
                    })
              ],
            ),
            body: isloading
                ? Container(
                    color: grocery_color_white,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : list.isNotEmpty
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            argument['isnav']
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Please Select Address To Deliver This Order',
                                      style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontFamily: fontBold,
                                          fontSize: textSizeMedium),
                                    ),
                                  )
                                : Container(),
                            ListView.builder(
                                padding: EdgeInsets.only(top: spacing_middle),
                                scrollDirection: Axis.vertical,
                                itemCount: list.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return AddressListWidget(
                                    list: list[index],
                                    isnav: argument['isnav'],
                                    mobile: mobile,
                                    index: index,
                                  );
                                }),
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
                          Text('Your Saved Address List Is Empty'),
                        ],
                      )),
          ),
          onWillPop: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                NewHomepage.Tag, (route) => false,
                arguments: {'id': 0});
          },
        );
      }
    } else {
      return Container(
        color: Colors.white,
      );
    }
  }
}
