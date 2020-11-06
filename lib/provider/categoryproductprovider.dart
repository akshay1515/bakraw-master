import 'dart:convert';

import 'package:bakraw/model/categoryproductmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../backend.dart';

class CategoryProductProvider with ChangeNotifier {
  List<Datum> _items = [];

  List<Datum> get items {
    return [..._items];
  }

  Datum _list;

  Datum get list {
    return _list;
  }

  Future<CategoryProduct> getProductBycategory(String CategoryI) async {
    const url = '${Utility.BaseURL}${'category-products.php?category_id='}';
    CategoryProduct catprod;
    Datum sample;
    final response = await http.get('${url}$CategoryI');
    Map<String, dynamic> decodeddata = jsonDecode(response.body);
    List<Datum> productlist = [];
    //print('decodedData: ${decodeddata['data']}');
    if (decodeddata['status'] == 200) {
      catprod = CategoryProduct.fromJson(decodeddata);
      catprod.data.forEach((element) {
        productlist.add(Datum(
          name: element.name,
          images: element.images,
          price: element.price,
          productId: element.productId,
        ));
        //print('decodedData${decodeddata}');
      });

      _items = productlist;
      return catprod;
    } else {
      catprod = CategoryProduct(
          status: decodeddata['status'], message: decodeddata['message']);
    }
    return catprod;
  }

  Future<Datum> UpdateOptionValue(String Selected) async {
    Datum options;
    options = Datum(productId: Selected);
    _list = options;
    notifyListeners();
    return options;
  }
}
