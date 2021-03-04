import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/useraddressmodel.dart';
import 'package:bakraw/model/usermodel.dart' as da;
import 'package:bakraw/provider/pincodeprovider.dart';
import 'package:bakraw/provider/useraddressprovider.dart';
import 'package:bakraw/screen/useraddresslist.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class EditUserAddress extends StatefulWidget {
  static const tag = '/EditUserAddress';
  Data model;

  EditUserAddress({this.model});

  @override
  _EditUserAddressState createState() => _EditUserAddressState();
}

TextEditingController firstNameCont = TextEditingController();
TextEditingController lastNameCont = TextEditingController();
TextEditingController pinCodeCont = TextEditingController();
TextEditingController cityCont = TextEditingController();
TextEditingController stateCont = TextEditingController();
TextEditingController addressCont = TextEditingController();
TextEditingController phoneNumberCont = TextEditingController();
TextEditingController countryCont = TextEditingController();
TextEditingController shippingaddress1 = TextEditingController();
TextEditingController shipfirstNameCont = TextEditingController();
TextEditingController shiplastNameCont = TextEditingController();
TextEditingController shippinCodeCont = TextEditingController();
TextEditingController shipcityCont = TextEditingController();
TextEditingController shipstateCont = TextEditingController();
TextEditingController shipaddressCont = TextEditingController();
TextEditingController shipphoneNumberCont = TextEditingController();
TextEditingController shipcountryCont = TextEditingController();
TextEditingController shipshippingaddress1 = TextEditingController();

GlobalKey<FormState> _shippingform = new GlobalKey<FormState>();
GlobalKey<FormState> _billingform = new GlobalKey<FormState>();

FocusNode firstnamefocus;
FocusNode lastnamefocus;
FocusNode pincodefocus;

FocusNode address1focus;
FocusNode address2focus;
FocusNode cityfocus;
FocusNode statefocus;
FocusNode countryfocus;
FocusNode billfirstnamefocus;
FocusNode billlastnamefocus;
FocusNode billpincodefocus;

FocusNode billaddress1focus;
FocusNode billaddress2focus;
FocusNode billcityfocus;
FocusNode billstatefocus;
FocusNode billcountryfocus;

List<String> checkpin = List();
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

  bool isloading = false;

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
    billfirstnamefocus = FocusNode();
    billlastnamefocus = FocusNode();
    billpincodefocus = FocusNode();
    billaddress1focus = FocusNode();
    billaddress2focus = FocusNode();
    billcityfocus = FocusNode();
    billstatefocus = FocusNode();
    billcountryfocus = FocusNode();
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
    billfirstnamefocus.dispose();
    billlastnamefocus.dispose();
    billpincodefocus.dispose();
    billaddress1focus.dispose();
    billaddress2focus.dispose();
    billcityfocus.dispose();
    billstatefocus.dispose();
    billcountryfocus.dispose();
    super.dispose();
  }

  init() async {
    countryCont.text = 'India';
    stateCont.text = 'Uttrakhand';
    cityCont.text = 'Dehradun';
    shipstateCont.text = stateCont.text;
    shipcityCont.text = cityCont.text;
    if (widget.model != null) {
      print(widget.model.address2);
      firstNameCont.text = widget.model.firstName;
      lastNameCont.text = widget.model.lastName;
      addressCont.text = widget.model.address1;
      shippingaddress1.text = widget.model.address2;
      cityCont.text = widget.model.city;
      pinCodeCont.text = widget.model.zip;
      phoneNumberCont.text = mobile;
      shipfirstNameCont.text = widget.model.firstName;
      shiplastNameCont.text = widget.model.lastName;
      shipaddressCont.text = widget.model.address1;
      shipshippingaddress1.text = widget.model.address2;
      shipcityCont.text = widget.model.city;
      shipstateCont.text = widget.model.state;
      shippinCodeCont.text = widget.model.zip;
      shipphoneNumberCont.text = mobile;
      Addressid = widget.model.id;
    }
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
        toast(value.message, length: Toast.LENGTH_SHORT);

        firstNameCont.clear();
        lastNameCont.clear();
        addressCont.clear();
        shippingaddress1.clear();
        cityCont.clear();
        stateCont.clear();
        countryCont.clear();
        pinCodeCont.clear();
        phoneNumberCont.clear();
        Navigator.of(context).popAndPushNamed(UserAddressManager.tag);
        setState(() {
          isloading = false;
        });
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
      onFieldSubmitted: (term) {
        FocusScope.of(context).requestFocus(billfirstnamefocus);
      },
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
        ]));

    final shipfirstName = TextFormField(
      focusNode: billfirstnamefocus,
      controller: shipfirstNameCont,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      autofocus: false,
      validator: (value) {
        if (value.isEmpty) {
          return 'Billing first name is required';
        } else {
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: (term) {
        FocusScope.of(context).requestFocus(billlastnamefocus);
      },
      decoration: formFieldDecoration('First Name'),
    );
    final shiplastName = TextFormField(
      focusNode: billlastnamefocus,
      controller: shiplastNameCont,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      validator: (value) {
        if (value.isEmpty) {
          return 'Billing last name is required';
        } else {
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      autofocus: false,
      onFieldSubmitted: (term) {
        FocusScope.of(context).requestFocus(billaddress1focus);
      },
      decoration: formFieldDecoration('Last Name'),
    );
    final shippinCode = TextFormField(
      controller: shippinCodeCont,
      focusNode: billpincodefocus,
      keyboardType: TextInputType.number,
      maxLength: 6,
      autofocus: false,
      onFieldSubmitted: (term) {},
      validator: (value) {
        if (value.isEmpty) {
          return 'Billing pincode is required';
        } else if (value.length != 6) {
          return 'Enter valid pincode';
        } else {
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.done,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      decoration: formFieldDecoration('Pin Code'),
    );
    final shipcity = TextFormField(
      controller: shipcityCont,
      focusNode: billcityfocus,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      onFieldSubmitted: (term) {
        FocusScope.of(context).requestFocus(billpincodefocus);
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Billing city is required';
        } else {
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.next,
      autofocus: false,
      decoration: formFieldDecoration('City Name'),
    );
    final shipstate = TextFormField(
      readOnly: true,
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      controller: shipstateCont,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      autofocus: false,
      textInputAction: TextInputAction.next,
      decoration: formFieldDecoration('State'),
    );
    final shipaddress = TextFormField(
      focusNode: billaddress1focus,
      controller: shipaddressCont,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) {
        FocusScope.of(context).requestFocus(billaddress2focus);
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Billing primary address is required';
        } else {
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: false,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      decoration: formFieldDecoration('Billing Address1'),
    );
    final shipaddress1 = TextFormField(
      focusNode: billaddress2focus,
      controller: shipshippingaddress1,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) {
        FocusScope.of(context).requestFocus(billcityfocus);
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Billing secondary address is required';
        } else {
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: false,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      decoration: formFieldDecoration('Billing Address2'),
    );

    final shipbody = Form(
        key: _shippingform,
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(child: shipfirstName),
              SizedBox(
                width: spacing_standard_new,
              ),
              Expanded(child: shiplastName),
            ],
          ),
          shipaddress,
          shipaddress1,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(child: shipcity),
              SizedBox(
                width: spacing_standard_new,
              ),
              Expanded(child: shipstate),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(child: shippinCode),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: saveButton,
          ),
        ]));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: grocery_color_white,
            ),
            onPressed: () {
              Navigator.of(context).popAndPushNamed(UserAddressManager.tag);
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
                  /* Container(
                width: double.infinity,
                color: grocery_lightGrey,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Billing Address',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )),
              ),*/
                  /* Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          copystatus = !copystatus;
                        });
                        if (copystatus == true) {
                          shipfirstNameCont.text = firstNameCont.text;
                          shiplastNameCont.text = lastNameCont.text;
                          shipaddressCont.text = addressCont.text;
                          shipshippingaddress1.text = shippingaddress1.text;
                          shipcityCont.text = cityCont.text;
                          shippinCodeCont.text = pinCodeCont.text;
                        } else if (copystatus) {
                          shipfirstNameCont.clear();
                          shiplastNameCont.clear();
                          shipaddressCont.clear();
                          shipshippingaddress1.clear();
                          shipcityCont.clear();
                          shippinCodeCont.clear();
                        }
                      },
                      icon: !copystatus
                          ? Icon(Icons.check_box_outline_blank_outlined)
                          : Icon(
                              Icons.check_box_sharp,
                              color: grocery_colorPrimary,
                            )),
                  Text('Same as shipping address'),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: shipbody,
              ),*/
                ],
              )),
    );
  }
}
