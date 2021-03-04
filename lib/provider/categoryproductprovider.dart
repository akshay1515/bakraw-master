import 'dart:convert';
import 'package:bakraw/model/categoryproductmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../backend.dart';

class CategoryProductProvider with ChangeNotifier {
  List<Data> _items = [];

  List<Data> get items {
    return [..._items];
  }

/*  Data _list;

  Data get list {
    return _list;
  }*/

  Future<CategoryProduct> getProductBycategory(String CategoryI) async {
    const url = '${Utility.BaseURL}${'category-products.php?category_id='}';
    CategoryProduct catprod;
    final response = await http.get('${url}$CategoryI');
    var decodeddata = jsonDecode(response.body);
    List<Data> productlist = [];
    if (decodeddata['status'] == 200) {
      catprod = CategoryProduct.fromJson(decodeddata);
      catprod.data.forEach((element) {
        productlist.add(Data(
            name: element.name,
            images: element.images,
            price: element.price,
            productId: element.productId,
            isProductIsInSale: element.isProductIsInSale));
      });

      _items = productlist;
      /*return catprod;*/
    } else {
      catprod = CategoryProduct(
          status: decodeddata['status'],
          message: decodeddata['message'],
          data: decodeddata['data']);
    }
    return catprod;
  }

 /* Future<Datum> UpdateOptionValue(String Selected) async {
    Datum options;
    options = Datum(productId: Selected);
    _list = options;
    notifyListeners();
    return options;
  }*/
}
