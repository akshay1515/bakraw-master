import 'dart:convert';

import 'package:bakraw/model/passwordmodel.dart';
import 'package:bakraw/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../backend.dart';

class ForgotProvider with ChangeNotifier {
  Future<ForgotPassword> userlogin(UserloginModel user) async {
    const url = '${Utility.BaseURL}${'forget-password.php'}';
    ForgotPassword userModel;
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_email': user.email}));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      userModel =
          ForgotPassword(status: data['status'], message: data['message']);
    }
    notifyListeners();
    return userModel;
  }
}
