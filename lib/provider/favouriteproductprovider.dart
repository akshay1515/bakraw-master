import 'dart:convert';

import 'package:bakraw/model/favouritemodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../backend.dart';

class UserFavouriteProvider with ChangeNotifier {
  List<Datas> _items = [];

  List<Datas> get items {
    return [..._items];
  }

  Future<FavouriteModel> getUserFavProduct(String userid, String apikey) async {
    const url = '${Utility.BaseURL}${'user-favorite-products.php'}';
    FavouriteModel model;
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json', 'apikey': apikey},
        body: jsonEncode({'user_id': userid, 'product_id': '5'}));
    Map<String, dynamic> decodeddata = jsonDecode(response.body);
    List<Datas> list = [];
    if (decodeddata['status'] == 200) {
      model = FavouriteModel.fromJson(decodeddata);
      model.data.forEach((element) {
        list.add(Datas(
            name: element.name,
            productId: element.productId,
            price: element.price,
            images: element.images,
            inStock: element.inStock,
            isProductHasSpecialPrice: element.isProductHasSpecialPrice,
            isProductIsInSale: element.isProductIsInSale,
            isProductNew: element.isProductNew,
            manageStock: element.manageStock,
            qty: element.qty,
            shortDescription: element.shortDescription,
            sku: element.sku,
            specialPrice: element.specialPrice,
            specialPriceType: element.specialPriceType));
      });
    } else {
      model = FavouriteModel.fromJson(decodeddata);
    }
    notifyListeners();
    return model;
  }
}
