import 'dart:convert';

import 'package:bakraw/model/couponsslidermodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../backend.dart';

class couponslideProvider with ChangeNotifier {
  List<Data> _items = [];

  List<Data> get items {
    return [..._items];
  }

  Future<couponSliderModel> getCategory() async {
    couponSliderModel slider;
    const url = '${Utility.BaseURL}${'coupons.php'}';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Data> sliderdata = [];
      if (data['status'] == 200) {
        slider = couponSliderModel.fromJson(data);
        slider.data.forEach((element) {
          sliderdata.add(Data(
            filePath: element.filePath,
            couponId: element.couponId
          ));
          _items = sliderdata;
        });
      } else {
        slider = couponSliderModel(status: data['status'], message: data['message']);
      }
    }
    notifyListeners();
    return slider;
  }
}
