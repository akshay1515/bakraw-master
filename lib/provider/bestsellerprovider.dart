import 'dart:convert';

import 'package:bakraw/backend.dart';
import 'package:bakraw/model/PreviousOrderModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BestSellerProvider with ChangeNotifier {
  List<PreviousOrderProduct> _items = [];

  List<PreviousOrderProduct> get items {
    return [..._items];
  }

  Future<PreviousOrderProduct> getBestSellingProducts() async {
    PreviousOrderProduct model;

    const url = '${Utility.BaseURL}${'best-selling-products.php'}';
    final response = await http.get(Uri.parse(url));
    List<PreviousOrderProduct> list = [];
    Map<String, dynamic> decodeddata = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (decodeddata['status'] == 200) {
        model = PreviousOrderProduct.fromJson(decodeddata);
        list.add(model);
      } else {}
    }
    _items = list;
    notifyListeners();
    return model;
  }
}
