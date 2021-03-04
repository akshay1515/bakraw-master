import 'dart:convert';
import 'dart:developer';

import 'package:bakraw/backend.dart';
import 'package:bakraw/model/paymentGatewayModels.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartToserverProvider with ChangeNotifier {
  Future<orderplacedmessage> PlaceOrderInCart(
      String model, String apikey) async {
    print(apikey);
    const url = '${Utility.BaseURL}${'add-order-details-in-server-db.php'}';
    orderplacedmessage modelm;
    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json', 'apikey': apikey},
          body: model);
      log(response.body);
      var decodeddata = jsonDecode(response.body);
      modelm = orderplacedmessage.fromJson(decodeddata);
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
    return modelm;
    /* Fluttertoast.showToast(
        msg: decodeddata['message'], toastLength: Toast.LENGTH_LONG);
  */
  }
}
