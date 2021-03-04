import 'dart:convert';

import 'package:bakraw/backend.dart';
import 'package:bakraw/model/useraddressmodel.dart';
import 'package:bakraw/model/usermodel.dart' as user;
import 'package:bakraw/screen/editadduseraddress.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserAddressProvider with ChangeNotifier {
  List<Data> _items = [];

  List<Data> get items {
    return [..._items];
  }

  Future<UserAddressModel> AddUpdateAddress(
      Data userAddress, user.Data mod) async {
    const url = '${Utility.BaseURL}${'add-update-address.php'}';
    UserAddressModel model;
    //print('address ${userAddress.billingAddress2} \n ${userAddress.userId} \n apikey');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json', 'apikey': mod.token},
        body: jsonEncode({
          'address_title': 'Home Addresss',
          'address_id': userAddress.id != null ?userAddress.id:'',
          'user_id': int.parse(userAddress.customerId),
          'user_firstname': userAddress.firstName,
          'user_lastname': userAddress.lastName,
          'user_email': mod.email,
          'user_phone': mod.phoneNumber,
          'billing_first_name': userAddress.firstName,
          'billing_last_name': userAddress.lastName,
          'billing_address_1': userAddress.address1,
          'billing_address_2': userAddress.address2,
          'billing_city': userAddress.city,
          'billing_state': userAddress.state,
          'billing_zip': userAddress.zip,
          'shipping_first_name': userAddress.firstName,
          'shipping_last_name': userAddress.lastName,
          'shipping_address_1': userAddress.address1,
          'shipping_address_2': userAddress.address2,
          'shipping_country': userAddress.country,
          'shipping_city': userAddress.city,
          'shipping_state': userAddress.state,
          'shipping_zip': userAddress.zip,
          'is_default': 1,
          'is_active': 1
        }));
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data.toString());

    model = UserAddressModel(status: data['status'], message: data['message']);
    //toast(userAddress.userEmail, length: Toast.LENGTH_SHORT);
    return model;
  }

  /*Future<UserAddressModel> DeleteAddress(
      AddressData userAddress, String apikey) async {
    const url = '${Utility.BaseURL}${'add-update-address.php'}';
    UserAddressModel model;
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json', 'apikey': apikey},
        body: jsonEncode({
          'address_title': 'Home',
          'address_id': userAddress.id,
          'user_id': int.parse(userAddress.customerId),
          'user_firstname': userAddress.firstName,
          'user_lastname': userAddress.lastName,
          'user_email': userAddress.userEmail,
          'user_phone': userAddress.userPhone,
          'billing_first_name': userAddress.billingFirstName,
          'billing_last_name': userAddress.billingLastName,
          'billing_address_1': userAddress.billingAddress1,
          'billing_address_2': userAddress.billingAddress2,
          'billing_city': userAddress.billingCity,
          'billing_state': userAddress.billingState,
          'billing_zip': userAddress.billingZip,
          'shipping_first_name': userAddress.shippingFirstName,
          'shipping_last_name': userAddress.shippingLastName,
          'shipping_address_1': userAddress.shippingAddress1,
          'shipping_address_2': userAddress.shippingAddress2,
          'shipping_country': userAddress.shippingCountry,
          'shipping_city': userAddress.shippingCity,
          'shipping_state': userAddress.shippingState,
          'shipping_zip': userAddress.shippingZip,
          'is_default': 1,
          'is_active': 1
        }));
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data.toString());

    model = UserAddressModel(status: data['status'], message: data['message']);
    //toast(userAddress.userEmail, length: Toast.LENGTH_SHORT);
    return model;
  }*/

  Future<UserAddressModel> getuserAddressList(
      String userid, String apikey) async {
    UserAddressModel model;
    const url = '${Utility.BaseURL}${'user-addresses.php'}';

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json', 'apikey': apikey},
        body: jsonEncode({'user_id': userid}));

    Map<String, dynamic> data = jsonDecode(response.body);
    print(response.body.toString());
    if (response.statusCode == 200) {
      if(data['status'] ==200){
        model = UserAddressModel.fromJson(data);
      }else{
        model = UserAddressModel(
          status: data['status'],
          message: data['message'],
          data: data['data']
        );
      }
    }
    notifyListeners();
    return model;
  }

  Future<Data> UpdateOptionValue(Data Selected) async {
    Data options;
    options = Data(id: Selected.id);
    notifyListeners();
    return options;
  }
}
