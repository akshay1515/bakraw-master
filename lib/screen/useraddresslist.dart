import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/pincodemodel.dart';
import 'package:bakraw/model/useraddressmodel.dart';
import 'package:bakraw/provider/pincodeprovider.dart';
import 'package:bakraw/provider/useraddressprovider.dart';
import 'package:bakraw/screen/checkpincode.dart';
import 'package:bakraw/screen/dashboard.dart';
import 'package:bakraw/screen/dashboaruderprofile.dart';
import 'package:bakraw/screen/editadduseraddress.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class UserAddressManager extends StatefulWidget {
  static String tag = '/AddressManagerScreen';
  bool istab = false;

  UserAddressManager({this.istab});

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
  List<addressData> list = [];
  bool isloading = true;

  var selectedValue;
  var sOptionPrice;

  @override
  void initState() {
    getUserInfo();
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

  SelectedRadio(addressData val) {
    setState(() {
      Provider.of<UserAddressProvider>(context, listen: false)
          .UpdateOptionValue(val);
    });
  }

  editAddress(addressData model) async {
    var bool = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => EditUserAddress(
                      model: model,
                    ))) ??
        false;
    if (bool) {}
  }

  @override
  Widget build(BuildContext context) {
    /* var sample = ModalRoute.of(context).settings.arguments as Map;
    */ /*List<CartsModel> carts = sample['cartitems'];
    double subtotal = sample['subtotal'];
    for (int i = 0; i < carts.length; i++) {
      print(carts[i].price);
    }*/
    var argument = ModalRoute.of(context).settings.arguments as Map;

    if (isloading) {
      Provider.of<UserAddressProvider>(context, listen: false)
          .getuserAddressList(userid, apikey)
          .then((value) {
        value.data.forEach((element) {
          list.add(addressData(
            addressTitle: element.addressTitle,
            id: element.id,
            userId: element.userId,
            userFirstname: element.userFirstname,
            userLastname: element.userLastname,
            userEmail: element.userEmail,
            userPhone: element.userPhone,
            billingFirstName: element.billingFirstName,
            billingLastName: element.billingLastName,
            billingAddress1: element.billingAddress1,
            billingAddress2: element.billingAddress2,
            billingCity: element.billingCity,
            billingState: element.billingState,
            billingZip: element.billingZip,
            shippingFirstName: element.shippingFirstName,
            shippingLastName: element.shippingLastName,
            shippingAddress1: element.shippingAddress1,
            shippingAddress2: element.shippingAddress2,
            shippingCity: element.shippingCity,
            shippingState: element.shippingState,
            shippingCountry: element.shippingCountry,
            shippingZip: element.shippingZip,
            isActive: element.isActive,
            isDefault: element.isDefault,
          ));
        });
        setState(() {
          isloading = false;
        });
      });
    }

    return WillPopScope(
      child: userid.isEmptyOrNull
          ? DefaultUserProfile(
              istab: false,
            )
          : Scaffold(
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
                            Dashboard.Tag, (route) => false);
                      }
                    }),
                title: Text(
                  'User Addresss',
                  style: TextStyle(color: grocery_color_white),
                ),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.add,
                        color: grocery_color_white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(EditUserAddress.tag);
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
                  : ListView.builder(
                      padding: EdgeInsets.only(top: spacing_middle),
                      scrollDirection: Axis.vertical,
                      itemCount: list.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: spacing_standard_new),
                          child: Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actions: <Widget>[
                              IconSlideAction(
                                caption: 'Edit',
                                color: Colors.green,
                                icon: Icons.edit,
                                onTap: () {
                                  editAddress(list[index]);
                                },
                              )
                            ],
                            child: InkWell(
                              onTap: () async {
                                PincodeModel model =
                                    await Provider.of<PincodeProvider>(context,
                                            listen: false)
                                        .checkpincodestatus(
                                            list[index].shippingZip);
                                if (model.status == 200) {
                                  if (!model.data.pincodeDeliveryStatus
                                      .allowDelivery) {
                                    return showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text('Sorry......'),
                                              content: Text(
                                                  'We aren\'t avaliable at your location yet'),
                                              actions: <Widget>[
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('Ok'))
                                              ],
                                            ));
                                  } else if (argument != null ||
                                      argument['isnav'] == true) {
                                    CheckPincode(model: list[index])
                                        .launch(context);
                                  }
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(spacing_standard_new),
                                margin: EdgeInsets.only(
                                  right: spacing_standard_new,
                                  left: spacing_standard_new,
                                ),
                                color: grocery_app_background,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Radio(
                                        value: list[index].id,
                                        /*index*/
                                        groupValue: selectedValue,
                                        onChanged: (value) {
                                          SelectedRadio(addressData(id: value));
                                        },
                                        activeColor: grocery_colorPrimary),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          text(
                                              list[index].userFirstname +
                                                  " " +
                                                  list[index].userLastname,
                                              textColor: textPrimaryColor,
                                              fontFamily: fontMedium,
                                              fontSize: textSizeLargeMedium),
                                          text(
                                              list[index].shippingAddress1 +
                                                  '\n' +
                                                  list[index].shippingAddress2,
                                              textColor: textPrimaryColor,
                                              fontSize: textSizeMedium),
                                          text(
                                              list[index].shippingCity +
                                                  "," +
                                                  list[index].shippingState,
                                              textColor: textPrimaryColor,
                                              fontSize: textSizeMedium),
                                          text(
                                              list[index].shippingCountry +
                                                  "," +
                                                  list[index].shippingZip,
                                              textColor: textPrimaryColor,
                                              fontSize: textSizeMedium),
                                          SizedBox(
                                            height: spacing_standard_new,
                                          ),
                                          text(list[index].userPhone,
                                              textColor: textPrimaryColor,
                                              fontSize: textSizeMedium),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
            ),
      onWillPop: () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Dashboard.Tag, (route) => false);
      },
    );
  }
}
