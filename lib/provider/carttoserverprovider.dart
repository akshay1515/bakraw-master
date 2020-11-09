import 'dart:convert';
import 'dart:developer';

import 'package:bakraw/backend.dart';
import 'package:bakraw/model/orderdetailsmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartToserverProvider with ChangeNotifier {
  Future<OrderDetailsModel> PlaceOrderInCart(
      String model, String apikey) async {
    print(apikey);
    const url = '${Utility.BaseURL}${'add-order-details-in-server-db.php'}';
    print(model);
    log(model);
    OrderDetailsModel modelm;
    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json', 'apikey': apikey},
          body: model);
      log(response.body);
      var decodeddata = jsonDecode(response.body);
      log('decodeddata ${decodeddata['message']}');
    } catch (e) {
      print(e.toString());
    }

    /* Fluttertoast.showToast(
        msg: decodeddata['message'], toastLength: Toast.LENGTH_LONG);
  */
  }
}
