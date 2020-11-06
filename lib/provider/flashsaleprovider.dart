import 'dart:convert';

import 'package:bakraw/backend.dart';
import 'package:bakraw/model/flashsalemodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FlashSaleProvider with ChangeNotifier {
  List<FlashsaleModel> _items = [];

  List<FlashsaleModel> get items {
    return [..._items];
  }

  Future<FlashsaleModel> getFlashSaleProduct() async {
    FlashsaleModel model;

    const url = '${Utility.BaseURL}${'flash-sales.php'}';
    final response = await http.get(url);
    List<FlashsaleModel> list = [];
    Map<String, dynamic> decodeddata = jsonDecode(response.body);
    if (response.statusCode == 200) {
      model = FlashsaleModel.fromJson(decodeddata);
      list.add(model);
    }
    _items = list;
    notifyListeners();
    return model;
  }
}
