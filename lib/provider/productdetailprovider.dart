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
    final response = await http.get('${url}${id}');
    //print('reponse${response.body}');
    var decodeddata = json.decode(response.body);

    /*  ProductSaleDetails pd = ProductSaleDetails(
        saleId: '21',
        saleProductId: '21',
        price: '21',
        qty: '21',
        isProductOutOfStock: true,
        endDate: DateTime.now(),
        sold: 4,
        saleName: 'demo');*/

    if (decodeddata['data']['product_sale_details'].length > 0) {
    } else {
      decodeddata['data']['product_sale_details'] = null;
    }

    if (decodeddata['status'] == 200) {
      print(decodeddata['data']);
      productModel = ProductModel.fromJson(decodeddata);
    } else {
      productModel = ProductModel(
          status: decodeddata['status'], message: decodeddata['message']);
    }
    //print(productModel.data.name);
    notifyListeners();
    return productModel;
  }

  Future<FavouriteModel> isFavourite(
      String userid, String apikey, String productid) async {
    FavouriteModel model;
    const url = '${Utility.BaseURL}${'user-favorite-products.php'}';
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json', 'apikey': apikey},
        body: jsonEncode({'user_id': userid, 'product_id': productid}));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      model = FavouriteModel.fromJson(data);
      /*print(
          'my status: ${model.data.firstWhere((element) => element.productId == productid).name}');*/
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
