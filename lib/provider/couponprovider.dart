import 'dart:convert';

import 'package:bakraw/backend.dart';
import 'package:bakraw/model/couponcodemoel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CouponProvider with ChangeNotifier {
  Future<CouponModel> verifyCuopon(
      String userid, String email, String apikey, String coupondata) async {
    const url = '${Utility.BaseURL}${'validate-coupon.php'}';
    CouponModel model;

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json', 'apikey': apikey},
        body: coupondata);

    if (response.statusCode == 200) {
      Map<String, dynamic> decodeddata = jsonDecode(response.body);

      if (decodeddata['status'] == 200) {
        model = CouponModel.fromJson(decodeddata);
      } else {
        Data data = Data(
            couponCode: "",
            couponId: "",
            discountAmount: "",
            freeShipping: false);
        model = CouponModel(
            status: decodeddata['status'],
            message: decodeddata['message'],
            data: data,
            hasError: true);
      }
    }
    return model;
  }
}
