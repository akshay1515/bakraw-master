import 'dart:convert';

import 'package:bakraw/backend.dart';
import 'package:bakraw/model/changepasswordmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Change_Password_Provider with ChangeNotifier {
  Future<ChangePasswordModel> Change_Password(String current_pwd,
      String new_pwd, String apikey, String email, String userid) async {
    ChangePasswordModel model;

    const url = '${Utility.BaseURL}${'change-password.php'}';

    final response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'apikey': apikey},
        body: jsonEncode({
          'user_id': userid,
          'user_email': email,
          'current_password': current_pwd,
          'new_password': new_pwd
        }));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      model = ChangePasswordModel.fromJson(data);
    }

    return model;
  }
}
