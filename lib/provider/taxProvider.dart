import 'dart:convert';

import 'package:bakraw/backend.dart';
import 'package:bakraw/model/taxmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TaxProvider with ChangeNotifier {
  Future<TaxModel> getTaxlist(
      String apikey, String userid, String email) async {
    final url = '${Utility.BaseURL}${'fetch-tax-classes.php'}';
    TaxModel model;
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json', 'apikey': apikey},
        body: jsonEncode({'user_id': userid, 'user_email': email}));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      model = TaxModel.fromJson(data);
    }
    return model;
  }
}
