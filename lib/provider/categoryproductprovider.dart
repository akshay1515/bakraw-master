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
    var decodeddata = jsonDecode(response.body);
    List<Datum> productlist = [];
    //print('decodedData: ${decodeddata['data']}');
    if (decodeddata['status'] == 200) {
      print('length ${decodeddata['data'].length}');
      for (int i = 0; i < decodeddata['data'].length; i++) {
        if (decodeddata['data'][i]['product_sale_details'].length > 0) {
        } else {
          decodeddata['data'][i]['product_sale_details'] = null;
        }
      }

      catprod = CategoryProduct.fromJson(decodeddata);
      catprod.data.forEach((element) {
        productlist.add(Datum(
            name: element.name,
            images: element.images,
            price: element.price,
            productId: element.productId,
            isProductIsInSale: element.isProductIsInSale));
        //print('decodedData${decodeddata}');
      });

      _items = productlist;
      return catprod;
    } else {
      catprod = CategoryProduct(
          status: decodeddata['status'],
          message: decodeddata['message'],
          data: decodeddata['data']);
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
