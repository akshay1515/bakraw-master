import 'dart:convert';

import 'package:bakraw/backend.dart';
import 'package:bakraw/model/useraddressmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserAddressProvider with ChangeNotifier {
  List<addressData> _items = [];

  List<addressData> get items {
    return [..._items];
  }

  Future<UserAddressModel> AddUpdateAddress(
      addressData userAddress, String apikey) async {
    const url = '${Utility.BaseURL}${'add-update-address.php'}';
    UserAddressModel model;
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json', 'apikey': apikey},
        body: jsonEncode({
          'address_title': userAddress.addressTitle,
          'address_id': userAddress.id,
          'user_id': int.parse(userAddress.userId),
          'user_firstname': userAddress.userFirstname,
          'user_lastname': userAddress.userLastname,
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
  }

  Future<UserAddressModel> DeleteAddress(
      addressData userAddress, String apikey) async {
    const url = '${Utility.BaseURL}${'add-update-address.php'}';
    UserAddressModel model;
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json', 'apikey': apikey},
        body: jsonEncode({
          'address_title': userAddress.addressTitle,
          'address_id': userAddress.id,
          'user_id': int.parse(userAddress.userId),
          'user_firstname': userAddress.userFirstname,
          'user_lastname': userAddress.userLastname,
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
  }

  Future<UserAddressModel> getuserAddressList(
      String userid, String apikey) async {
    UserAddressModel model;
    const url = '${Utility.BaseURL}${'user-addresses.php'}';

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json', 'apikey': apikey},
        body: jsonEncode({'user_id': userid}));

    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      model = UserAddressModel.fromJson(data);
    }
    return model;
  }

  Future<addressData> UpdateOptionValue(addressData Selected) async {
    addressData options;
    options = addressData(id: Selected.id);
    notifyListeners();
    return options;
  }
}
