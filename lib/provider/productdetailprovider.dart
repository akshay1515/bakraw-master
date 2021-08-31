import 'dart:convert';

import 'package:bakraw/model/favouritemodel.dart';
import 'package:bakraw/model/productmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../backend.dart';

class ProductProvider with ChangeNotifier {
  Options _items;

  Options get items {
    return _items;
  }

  Future<ProductModel> getProductDetails(String id) async {
    const url = '${Utility.BaseURL}${'product-details.php?product_id='}';
    ProductModel productModel;
    final response = await http.get(Uri.parse('${url}${id}'));
    var decodeddata = json.decode(response.body);

    if (decodeddata['status'] == 200) {
      productModel = ProductModel.fromJson(decodeddata);
    } else {
      productModel = ProductModel(
          status: decodeddata['status'], message: decodeddata['message']);
    }
    notifyListeners();
    return productModel;
  }

  Future<FavouriteModel> isFavourite(
      String userid, String apikey, String productid) async {
    FavouriteModel model;
    const url = '${Utility.BaseURL}${'user-favorite-products.php'}';
    final response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'apikey': apikey},
        body: jsonEncode({
          'user_id': num.tryParse(userid),
          'product_id': num.tryParse(productid)
        }));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      model = FavouriteModel.fromJson(data);
    }
    return model;
  }

  Future<Options> UpdateOptionValue(Options Selected) async {
    Options options;
    options = Options(
      optionValueId: Selected.optionValueId,
      increaseProductPriceBy: Selected.increaseProductPriceBy,
      price: Selected.price,
      name: Selected.name,
      label: Selected.label,
    );
    _items = options;
    notifyListeners();
    return options;
  }
}
