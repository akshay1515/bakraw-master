import 'package:bakraw/GlobalWidget/GlobalWidget.dart';
import 'package:bakraw/model/useraddressmodel.dart';
import 'package:bakraw/provider/useraddressprovider.dart';
import 'package:bakraw/screen/useraddresslist.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:bakraw/utils/GroceryConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class EditUserAddress extends StatefulWidget {
  static const tag = '/EditUserAddress';
  addressData model;

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

class _EditUserAddressState extends State<EditUserAddress> {
  addressData userAddress;
  String Addressid = "";
  String email = '';
  String apikey = '';
  String userid = '';
  String fname = '';
  String lname = '';
  String mobile = '';
  List<addressData> list = [];
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    getUserInfo();
    init();
  }

  init() async {
    if (widget.model != null) {
      firstNameCont.text = widget.model.shippingFirstName;
      lastNameCont.text = widget.model.shippingLastName;
      addressCont.text = widget.model.shippingAddress1;
      shippingaddress1.text = widget.model.shippingAddress2;
      cityCont.text = widget.model.shippingCity;
      stateCont.text = widget.model.shippingState;
      countryCont.text = widget.model.shippingCountry;
      pinCodeCont.text = widget.model.shippingZip;
      phoneNumberCont.text = widget.model.userPhone;
      shipfirstNameCont.text = widget.model.billingFirstName;
      shiplastNameCont.text = widget.model.billingLastName;
      shipaddressCont.text = widget.model.billingAddress1;
      shipshippingaddress1.text = widget.model.billingAddress2;
      shipcityCont.text = widget.model.billingCity;
      shipstateCont.text = widget.model.billingState;
      shippinCodeCont.text = widget.model.billingZip;
      shipphoneNumberCont.text = widget.model.userPhone;
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
    print('apikey $apikey');
    return email;
  }

  @override
  Widget build(BuildContext context) {
    void onSaveClicked() async {
      setState(() {
        isloading = true;
      });

      userAddress = addressData(
        addressTitle: 'Home',
        id: Addressid,
        shippingZip: pinCodeCont.text,
        shippingCountry: countryCont.text,
        shippingState: stateCont.text,
        shippingCity: cityCont.text,
        shippingAddress1: addressCont.text,
        shippingAddress2: shippingaddress1.text,
        shippingFirstName: firstNameCont.text,
        shippingLastName: lastNameCont.text,
        billingZip: shippinCodeCont.text,
        billingState: shipstateCont.text,
        billingCity: shipcityCont.text,
        billingAddress1: shipaddressCont.text,
        billingAddress2: shipshippingaddress1.text,
        billingFirstName: shipfirstNameCont.text,
        billingLastName: shiplastNameCont.text,
        userEmail: email,
        userPhone: mobile,
        userFirstname: fname,
        userLastname: lname,
        userId: userid,
        isActive: '1',
        isDefault: '1',
      );

      Provider.of<UserAddressProvider>(context, listen: false)
          .AddUpdateAddress(userAddress, apikey)
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

        shipfirstNameCont.clear();

        shiplastNameCont.clear();

        shipaddressCont.clear();

        shipshippingaddress1.clear();

        shipcityCont.clear();
        shipstateCont.clear();
        shippinCodeCont.clear();

        Navigator.of(context).popAndPushNamed(UserAddressManager.tag);
        setState(() {
          isloading = false;
        });
      });
    }

    final firstName = TextFormField(
      controller: firstNameCont,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      autofocus: false,
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      decoration: formFieldDecoration('First Name'),
    );

    final lastName = TextFormField(
      controller: lastNameCont,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      autofocus: false,
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      decoration: formFieldDecoration('Last Name'),
    );

    final pinCode = TextFormField(
      controller: pinCodeCont,
      keyboardType: TextInputType.number,
      maxLength: 6,
      autofocus: false,
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      textInputAction: TextInputAction.next,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      decoration: formFieldDecoration('Pin Code'),
    );

    final city = TextFormField(
      controller: cityCont,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      textInputAction: TextInputAction.next,
      autofocus: false,
      decoration: formFieldDecoration('City Name'),
    );

    final state = TextFormField(
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      controller: stateCont,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      autofocus: false,
      textInputAction: TextInputAction.next,
      decoration: formFieldDecoration('State'),
    );

    final country = TextFormField(
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
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
      keyboardType: TextInputType.multiline,
      maxLines: 4,
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      autofocus: false,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      decoration: formFieldDecoration('Shipping Address1'),
    );

    final address1 = TextFormField(
      controller: shippingaddress1,
      keyboardType: TextInputType.multiline,
      maxLines: 4,
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
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
        if (firstNameCont.text.isEmpty) {
          toast("Shipping First name required");
        } else if (lastNameCont.text.isEmpty) {
          toast("Shipping Last name required");
        } else if (addressCont.text.isEmpty) {
          toast("Shipping Address required");
        } else if (cityCont.text.isEmpty) {
          toast("Shipping City name required");
        } else if (stateCont.text.isEmpty) {
          toast("Shipping State name required");
        } else if (countryCont.text.isEmpty) {
          toast("Shipping Country name required");
        } else if (pinCodeCont.text.isEmpty) {
          toast("Shipping Pincode required");
        } else if (shippingaddress1.text.isEmptyOrNull) {
          toast('Shipping Shipping address 1 is required');
        } else if (shipfirstNameCont.text.isEmpty) {
          toast("Billing First name required");
        } else if (shiplastNameCont.text.isEmpty) {
          toast("Billing Last name required");
        } else if (shipaddressCont.text.isEmpty) {
          toast("Billing Address required");
        } else if (shipcityCont.text.isEmpty) {
          toast("Billing City name required");
        } else if (shipstateCont.text.isEmpty) {
          toast("Billing State name required");
        } else if (shippinCodeCont.text.isEmpty) {
          toast("Billing Pincode required");
        } else if (shipshippingaddress1.text.isEmptyOrNull) {
          toast('Billing address 1 is required');
        } else {
          onSaveClicked();
        }
      },
      color: grocery_colorPrimary,
      child: text('Save Address',
          fontFamily: fontMedium,
          fontSize: textSizeLargeMedium,
          textColor: grocery_color_white),
    );

    final body = Wrap(runSpacing: spacing_standard_new, children: <Widget>[
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
    ]);

    final shipfirstName = TextFormField(
      controller: shipfirstNameCont,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      autofocus: false,
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      decoration: formFieldDecoration('First Name'),
    );

    final shiplastName = TextFormField(
      controller: shiplastNameCont,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      autofocus: false,
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      decoration: formFieldDecoration('Last Name'),
    );

    final shippinCode = TextFormField(
      controller: shippinCodeCont,
      keyboardType: TextInputType.number,
      maxLength: 6,
      autofocus: false,
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      textInputAction: TextInputAction.next,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      decoration: formFieldDecoration('Pin Code'),
    );

    final shipcity = TextFormField(
      controller: shipcityCont,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      textInputAction: TextInputAction.next,
      autofocus: false,
      decoration: formFieldDecoration('City Name'),
    );

    final shipstate = TextFormField(
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
      controller: shipaddressCont,
      keyboardType: TextInputType.multiline,
      maxLines: 4,
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      autofocus: false,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      decoration: formFieldDecoration('Billing Address1'),
    );

    final shipaddress1 = TextFormField(
      controller: shipshippingaddress1,
      keyboardType: TextInputType.multiline,
      maxLines: 4,
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      autofocus: false,
      style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
      decoration: formFieldDecoration('Billing Address2'),
    );

    final shipbody = Wrap(runSpacing: spacing_standard_new, children: <Widget>[
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
    ]);

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
              width: double.infinity,
              child: SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: body,
                  ),
                  Container(
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
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: shipbody,
                  ),
                ],
              ))),
    );
  }
}
