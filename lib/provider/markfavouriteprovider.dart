import 'dart:convert';

import 'package:bakraw/model/markfavouritemodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../backend.dart';

class MarkFavourite with ChangeNotifier {
  Future<FavouriteModel> markFavourites(
      String userid, String productId, String apikey) async {
    const url = '${Utility.BaseURL}${'mark-unmark-product-as-favorite.php'}';
    FavouriteModel model;
    final response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'apikey': apikey},
        body: jsonEncode({
          'user_id': num.tryParse(userid),
          'product_id': num.tryParse(productId)
        }));
    var sample = jsonDecode(response.body);
    model =
        FavouriteModel(status: sample['status'], message: sample['message']);

    return model;
  }
}
