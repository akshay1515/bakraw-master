import 'dart:convert';

import 'package:bakraw/backend.dart';
import 'package:bakraw/model/deliveryslotmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class DeliverySlotProvider with ChangeNotifier {
  List<DeliverySlotModel> _items = [];

  List<DeliverySlotModel> get items {
    return [..._items];
  }

  String _value = '';

  String get value {
    return _value;
  }

  Future<DeliverySlotModel> getDeliverySlot() async {
    const url = '${Utility.BaseURL}${'delivery-slots.php'}';
    DeliverySlotModel model;
    final response = await http.get(url);
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      model = DeliverySlotModel.fromJson(data);
    }
    return model;
  }

  Future<String> UpdateOptionValue(String Selected) async {
    return Selected;
  }
}
