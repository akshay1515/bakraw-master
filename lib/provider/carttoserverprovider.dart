import 'dart:convert';

import 'package:bakraw/backend.dart';
import 'package:bakraw/model/addtocartmodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

class CartToserverProvider with ChangeNotifier {
  Future PlaceOrderInCart(DbcarTmodel model, String apikey) async {
    const url = '${Utility.BaseURL}${'add-order-details-in-server-db.php'}';
    String temp = jsonEncode(model.toJson());
    print(temp);
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json', 'apikey': apikey},
        body: temp);
    Map<String, dynamic> decodeddata = jsonDecode(response.body);

    Fluttertoast.showToast(
        msg: decodeddata['message'], toastLength: Toast.LENGTH_LONG);
  }
}
