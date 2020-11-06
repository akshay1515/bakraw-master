import 'dart:convert';

import 'package:bakraw/backend.dart';
import 'package:bakraw/model/shipmethod.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShipmethodProvider with ChangeNotifier {
  List<ShipMethodModel> _items = [];

  List<ShipMethodModel> get items {
    return [..._items];
  }

  Future<ShipMethodModel> getShippingmethod(
      String userid, String email, String apikey) async {
    const url = '${Utility.BaseURL}${'get-shipping-methods.php'}';
    ShipMethodModel model;
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json', 'apikey': apikey},
        body: jsonEncode({'user_id': userid, 'user_email': email}));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      model = ShipMethodModel.fromJson(data);
    }
    notifyListeners();
    return model;
  }
}
