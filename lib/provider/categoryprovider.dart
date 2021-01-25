import 'dart:convert';

import 'package:bakraw/model/categorymodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../backend.dart';

class CategoryProvider with ChangeNotifier {
  List<Data> _items = [];

  List<Data> get items {
    return [..._items];
  }

  Future<CategoryModel> getCategories() async {
    const url = '${Utility.BaseURL}${'categories.php'}';
    CategoryModel category;
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> decodeddata = jsonDecode(response.body);
      List<Data> catlist = [];
      if (decodeddata['status'] == 200) {
        category = CategoryModel.fromJson(decodeddata);
        category.data.forEach((element) {
          catlist.add(Data(
              name: element.name,
              categoryId: element.categoryId,
              slug: element.slug,
              sequence: element.sequence,
              images: element.images));
        });
        _items = catlist;
      } else {
        category = CategoryModel(
            status: decodeddata['status'], message: decodeddata['message']);
      }
      //print('"message :"${decodeddata['message']}');
      //print('"Data:"${decodeddata['data']}');
    }
    notifyListeners();
    return category;
  }
}
