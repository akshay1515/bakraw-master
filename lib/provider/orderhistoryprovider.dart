import 'dart:convert';

import 'package:bakraw/backend.dart';
import 'package:bakraw/model/orderhistorymodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderHistoryProvider with ChangeNotifier {
  List<Data> _items = [];

  List<Data> get items {
    return [..._items];
  }

  Future<OrderHistoryModel> getPastOrder(
      {String apikey, String userid, String email}) async {
    //print('object $userid, $email, $apikey');
    const url = '${Utility.BaseURL}${'past-orders.php'}';
    OrderHistoryModel model;
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json', 'apikey': apikey},
        body: jsonEncode({'user_id': userid, 'user_email': email}));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<Data> list = [];
      model = OrderHistoryModel.fromJson(data);
      model.data.forEach((element) {
        list.add(Data(
            status: element.status,
            createdAt: element.createdAt,
            orderId: element.orderId,
            subTotal: element.subTotal,
            total: element.total));
      });
      _items = list;
      notifyListeners();
      return model;
    }
  }
}
