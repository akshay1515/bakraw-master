import 'dart:convert';

import 'package:bakraw/backend.dart';
import 'package:bakraw/model/relatedproductsmodels.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RelatedProductProvier with ChangeNotifier {
  List<RelatedProductModel> _items = [];

  List<RelatedProductModel> get items {
    return [..._items];
  }

  Future<RelatedProductModel> getRelatedProducts(String productid) async {
    RelatedProductModel model;

    const url =
        '${Utility.BaseURL}${'product-related-products.php?product_id='}';
    final response = await http.get(Uri.parse('${url}$productid'));
    List<RelatedProductModel> list = [];
    Map<String, dynamic> decodeddata = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (decodeddata['data'] != null) {
        model = RelatedProductModel.fromJson(decodeddata);
        list.add(model);
        _items = list;
      } else {
        model = RelatedProductModel(
            status: decodeddata['code'],
            data: decodeddata['data'],
            message: decodeddata['message']);
      }
    }

    notifyListeners();
    return model;
  }
}
