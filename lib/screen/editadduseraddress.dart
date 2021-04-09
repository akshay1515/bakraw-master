import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/useraddressmodel.dart';
import 'package:bakraw/model/usermodel.dart' as da;
import 'package:bakraw/provider/pincodeprovider.dart';
import 'package:bakraw/provider/useraddressprovider.dart';
import 'package:bakraw/screen/newui/newgooglemap.dart';
import 'package:bakraw/screen/useraddresslist.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditUserAddress extends StatefulWidget {
  static const tag = '/EditUserAddress';
  Data model;
  final bool isnav;

  EditUserAddress({this.model, this.isnav});

  @override
  _EditUserAddressState createState() => _EditUserAddressState();
}

List<String> checkpin = [];
bool loadlist = true;
bool status = false;
bool copystatus = false;

class _EditUserAddressState extends State<EditUserAddress> {
  Data userAddress;
  String Addressid = "";
  String email = '';
  String apikey = '';
  String userid = '';
  String fname = '';
  String lname = '';
  String mobile = '';
  List<Data> list = [];

  TextEditingController firstNameCont = TextEditingController();
  TextEditingController lastNameCont = TextEditingController();
  TextEditingController pinCodeCont = TextEditingController();
  TextEditingController cityCont = TextEditingController();
  TextEditingController stateCont = TextEditingController();
  TextEditingController addressCont = TextEditingController();
  TextEditingController phoneNumberCont = TextEditingController();
  TextEditingController countryCont = TextEditingController();
  TextEditingController shippingaddress1 = TextEditingController();

  FocusNode firstnamefocus;
  FocusNode lastnamefocus;
  FocusNode pincodefocus;

  FocusNode address1focus;
  FocusNode address2focus;
  FocusNode cityfocus;
  FocusNode statefocus;
  FocusNode countryfocus;

  bool isloading = false;
  GlobalKey<FormState> _billingform = new GlobalKey<FormState>();

  @override
  void initState() {
    firstnamefocus = FocusNode();
    lastnamefocus = FocusNode();
    pincodefocus = FocusNode();
    address1focus = FocusNode();
    address2focus = FocusNode();
    cityfocus = FocusNode();
    statefocus = FocusNode();
    countryfocus = FocusNode();
    super.initState();
    getUserInfo();
    init();
    setState(() {
      isloading = true;
    });
  }

  @override
  void dispose() {
    firstnamefocus.dispose();
    lastnamefocus.dispose();
    pincodefocus.dispose();
    address1focus.dispose();
    address2focus.dispose();
    cityfocus.dispose();
    statefocus.dispose();
    countryfocus.dispose();
    super.dispose();
  }

  void setuserAddress() {
    countryCont.text = 'India';
    stateCont.text = 'Uttrakhand';
    cityCont.text = 'Dehradun';
    if (widget.model != null) {
      firstNameCont.text = widget.model.firstName;
      lastNameCont.text = widget.model.lastName;
      addressCont.text = widget.model.address1;
      shippingaddress1.text = widget.model.address2;
      cityCont.text = widget.model.city;
      pinCodeCont.text = widget.model.zip;
      phoneNumberCont.text = mobile;
      Addressid = widget.model.id;
    }
  }

  init() async {
    setuserAddress();
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
    return apikey;
  }

  /*Data checkData() {
    var useraddress = Provider.of<UserAddressProvider>(context).options;
    return useraddress;
  }*/

  @override
  Widget build(BuildContext context) {
    if (isloading && loadlist) {
      Provider.of<PincodeProvider>(context, listen: false)
          .checkpincodestatus('440009')
          .then((value) {
        value.data.pincodes.forEach((element) {
          checkpin.add(element.toString());
        });
        setState(() {
          isloading = false;
        });
      });
    }

    /*if (checkData() != null) {
      countryCont.text = checkData().country;
      stateCont.text = checkData().state;
      cityCont.text = checkData().city;

      firstNameCont.text =
          checkData().firstName != null ? checkData().firstName : '';
      lastNameCont.text =
          checkData().lastName != null ? checkData().lastName : '';
      addressCont.text = checkData().address1;
      shippingaddress1.text = checkData().address2;
      pinCodeCont.text = checkData().zip;
      phoneNumberCont.text = mobile;
      Addressid = checkData().id != null ? checkData().id : '';
    }*/

    void onSaveClicked() {
      setState(() {
        isloading = true;
      });

      userAddress = Data(
        firstName: firstNameCont.text,
        lastName: lastNameCont.text,
        customerId: userid,
        id: Addressid,
        address1: addressCont.text,
        address2: shippingaddress1.text,
        city: cityCont.text,
        country: countryCont.text,
        state: stateCont.text,
        zip: pinCodeCont.text,
      );

      Provider.of<UserAddressProvider>(context, listen: false)
          .AddUpdateAddress(
              userAddress,
              da.Data(
                userId: userid,
                firstName: fname,
                lastName: lname,
                token: apikey,
                email: email,
                phoneNumber: mobile,
              ))
          .then((value) {
        Fluttertoast.showToast(
            msg: value.message, toastLength: Toast.LENGTH_LONG);

        if (value.status == 200) {
          firstNameCont.clear();
          lastNameCont.clear();
          addressCont.clear();
          shippingaddress1.clear();
          cityCont.clear();
          stateCont.clear();
          countryCont.clear();
          pinCodeCont.clear();
          phoneNumberCont.clear();
          /*  Provider.of<UserAddressProvider>(context, listen: false).options =
              Data();*/
          /* setState(() {
            isloading = false;
          });*/
          Navigator.of(context).popAndPushNamed(UserAddressManager.tag,
              arguments: {'isnav': widget.isnav});
        } else {
          setState(() {
            isloading = false;
          });
        }
      });
    }

    final firstName = TextFormField(
      focusNode: firstnamefocus,
      controller: firstNameCont,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      autofocus: true,
      validator: (value) {
        if (value.isEmpty) {
          return 'Shipping First name is required';
        } else {
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: (term) {
        FocusScope.of(context).requestFocus(lastnamefocus);
      },
      decoration: formFieldDecoration('First Name'),
    );
    final lastName = TextFormField(
      focusNode: lastnamefocus,
      controller: lastNameCont,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      validator: (value) {
        if (value.isEmpty) {
          return 'Shipping last name is required';
        } else {
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: (term) {
        FocusScope.of(context).requestFocus(address1focus);
      },
      decoration: formFieldDecoration('Last Name'),
    );
    final pinCode = TextFormField(
      focusNode: pincodefocus,
      controller: pinCodeCont,
      keyboardType: TextInputType.number,
      maxLength: 6,
      validator: (value) {
        if (value.isEmpty) {
          return 'Shipping pin code is required';
        } else if (value.length != 6) {
          return 'Enter valid pincode';
        } else if (value.length == 6) {
          status = checkpin.contains(value);
          if (!status) {
            return 'We do not deliver here yet';
          } else {
            return null;
          }
        } else {
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.next,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      decoration: formFieldDecoration('Pin Code'),
    );
    final city = TextFormField(
      controller: cityCont,
      focusNode: cityfocus,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      validator: (value) {
        if (value.isEmpty) {
          return 'Shipping city is required';
        } else {
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: (term) {
        FocusScope.of(context).requestFocus(pincodefocus);
      },
      textInputAction: TextInputAction.next,
      autofocus: false,
      decoration: formFieldDecoration('City Name'),
    );
    final state = TextFormField(
      focusNode: statefocus,
      readOnly: true,
      onFieldSubmitted: (term) {
        FocusScope.of(context).requestFocus(pincodefocus);
      },
      controller: stateCont,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      validator: (value) {
        if (value.isEmpty) {
          return 'Shipping state is required';
        } else {
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      autofocus: false,
      textInputAction: TextInputAction.next,
      decoration: formFieldDecoration('State'),
    );
    final country = TextFormField(
      focusNode: countryfocus,
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      readOnly: true,
      validator: (value) {
        if (value.isEmpty) {
          return 'Shipping country is required';
        } else {
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: countryCont,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      autofocus: false,
      textInputAction: TextInputAction.next,
      decoration: formFieldDecoration("Country"),
    );
    final address = TextFormField(
      controller: addressCont,
      focusNode: address1focus,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) {
        FocusScope.of(context).requestFocus(address2focus);
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Shipping primary address is required';
        } else {
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: false,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      decoration: formFieldDecoration('Shipping Address1'),
    );
    final address1 = TextFormField(
      controller: shippingaddress1,
      focusNode: address2focus,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) {
        FocusScope.of(context).requestFocus(cityfocus);
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Shipping secondary address is required';
        } else {
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: false,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      decoration: formFieldDecoration('Shipping Address2'),
    );
    final saveButton = MaterialButton(
      height: 50,
      minWidth: double.infinity,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
      onPressed: () {
        if (_billingform.currentState.validate()) {
          onSaveClicked();
        } else {
          Fluttertoast.showToast(
              msg: 'Please check the details you have filled',
              toastLength: Toast.LENGTH_SHORT);
        }
      },
      color: grocery_colorPrimary,
      child: text('Save Address',
          fontFamily: fontMedium,
          fontSize: textSizeLargeMedium,
          textColor: grocery_color_white),
    );

    final body = Form(
        key: _billingform,
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(child: firstName),
              SizedBox(
                width: spacing_standard_new,
              ),
              Expanded(child: lastName),
            ],
          ),
          address,
          address1,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(child: city),
              SizedBox(
                width: spacing_standard_new,
              ),
              Expanded(child: state),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(child: country),
              SizedBox(
                width: spacing_standard_new,
              ),
              Expanded(child: pinCode),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: saveButton,
          ),
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: grocery_colorPrimary,
              ),
              onPressed: () {
                Navigator.of(context).popAndPushNamed(GoogleMapActivity.Tag,
                    arguments: {'data': widget.model, 'isnav': widget.isnav});
              },
              child: Text('Open On Maps'),
            ),
          )
        ]));

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: grocery_color_white,
              ),
              onPressed: () {
                Navigator.of(context).popAndPushNamed(UserAddressManager.tag,
                    arguments: {'isnav': widget.isnav});
              }),
          title: Text(
            'Add/Edit Shipping Address',
            style: TextStyle(color: grocery_color_white),
          ),
        ),
        body: isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: grocery_lightGrey,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Shipping Address',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )),
                    ),
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: body,
                      ),
                    )
                  ],
                )),
      ),
      onWillPop: () {
        Navigator.of(context).popAndPushNamed(UserAddressManager.tag,
            arguments: {'isnav': widget.isnav});
        dispose();
        return;
      },
    );
  }
}
