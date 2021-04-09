import 'dart:convert';

import 'package:bakraw/model/usermodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../backend.dart';

class UserProvider with ChangeNotifier {
  Future<UserModel> userlogin(UserloginModel user) async {
    const url = '${Utility.BaseURL}${'signin.php'}';
    UserModel userModel;
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': user.email, 'password': user.password}));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['status'] == 200) {
        userModel = UserModel.fromJson(data);
      } else {
        userModel = UserModel(status: data['status'], message: data['message']);
      }
    }
    notifyListeners();
    return userModel;
  }

  Future<UserModel> usersignup(Data signup) async {
    const url = '${Utility.BaseURL}${'signup.php'}';
    UserModel model;
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'first_name': signup.firstName,
          'last_name': signup.lastName,
          'email': signup.email,
          'phone_number': signup.phoneNumber,
        }));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 200) {
        model = UserModel.fromJson(data);
      } else {
        model = UserModel(status: data['status'], message: data['message']);
      }
    }
    notifyListeners();
    return model;
  }
}
