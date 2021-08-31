import 'dart:convert';

import 'package:bakraw/backend.dart';
import 'package:bakraw/model/deliverytextmodel.dart' as text;
import 'package:bakraw/model/shipmethod.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShipmethodProvider with ChangeNotifier {
  ShipMethodModel _items = ShipMethodModel();

  ShipMethodModel get items => _items;

  Future<ShipMethodModel> getShippingmethod(
      String userid, String email, String apikey) async {
    const url = '${Utility.BaseURL}${'get-shipping-methods.php'}';
    ShipMethodModel model;
    final response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'apikey': apikey},
        body: jsonEncode({'user_id': userid, 'user_email': email}));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      model = ShipMethodModel.fromJson(data);
      _items = ShipMethodModel(
          status: model.status, data: model.data, message: model.message);
    }
    notifyListeners();
    return model;
  }

  Future<text.DeliveryTextModel> getDeliveryText() async {
    const url = '${Utility.BaseURL}${'delivery-text.php'}';
    text.DeliveryTextModel model;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data['data'].isNotEmpty) {
        model = text.DeliveryTextModel.fromJson(data);
      } else {
        model = text.DeliveryTextModel(
            status: data['status'],
            message: data['message'],
            data: data['data']);
      }
    }
    notifyListeners();
    return model;
  }
}
