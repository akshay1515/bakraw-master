import 'dart:convert';

import 'package:bakraw/model/slidermodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../backend.dart';

class SliderProvider with ChangeNotifier {
  List<Data> _items = [];

  List<Data> get items {
    return [..._items];
  }

  Future<SliderModel> getCategory() async {
    SliderModel slider;
    const url = '${Utility.BaseURL}${'slider-products.php'}';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Data> sliderdata = [];
      if (data['status'] == 200) {
        slider = SliderModel.fromJson(data);
        slider.data.forEach((element) {
          sliderdata.add(Data(
            productId: element.productId,
            name: element.name,
            image: element.image,
          ));
          _items = sliderdata;
        });
      } else {
        slider = SliderModel(status: data['status'], message: data['message']);
      }
    }
    notifyListeners();
    return slider;
  }
}
