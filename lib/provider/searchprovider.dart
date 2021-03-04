import 'dart:convert';
import 'dart:developer';
import 'package:bakraw/backend.dart';
import 'package:bakraw/model/searchmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchProvider with ChangeNotifier {
  List<SearchModel> _items = [];

  List<SearchModel> get items {
    return [..._items];
  }

  Future<SearchModel> searchProducts(String search) async {
    const url = '${Utility.BaseURL}${'search.php?s='}';
    SearchModel model;
    final response = await http.get('${url}$search');

    if (response.statusCode == 200) {
      var decodeddata = jsonDecode(response.body);
      log(decodeddata.toString());
      if (decodeddata['status'] == 200) {
        model = SearchModel.fromJson(decodeddata);
      } else {
        model = SearchModel.fromJson(decodeddata);
      }
    }
    notifyListeners();
    return model;
  }
}
