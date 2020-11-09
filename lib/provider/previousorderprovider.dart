import 'dart:convert';

import 'package:bakraw/backend.dart';
import 'package:bakraw/model/PreviousOrderModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PreviousOrderProvider with ChangeNotifier {
  List<PreviousOrderProduct> _items = [];

  List<PreviousOrderProduct> get items {
    return [..._items];
  }

  Future<PreviousOrderProduct> getFlashSaleProduct(
      String apikey, String Userid, String email) async {
    PreviousOrderProduct model;

    const url = '${Utility.BaseURL}${'previous-orders-products.php'}';
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json', 'apikey': apikey},
        body: jsonEncode({'user_id': Userid, 'user_email': email}));
    List<PreviousOrderProduct> list = [];
    Map<String, dynamic> decodeddata = jsonDecode(response.body);
    if (response.statusCode == 200) {
      model = PreviousOrderProduct.fromJson(decodeddata);
      list.add(model);
    }
    _items = list;
    notifyListeners();
    return model;
  }
}
